conn = Userdata.new("conn")
db = conn.sqlite

r = Nginx::Request.new
#code = Nginx::HTTP_MOVED_PERMANENTLY
code = Nginx::HTTP_MOVED_TEMPORARILY

s = 0 # when on debug 0 ??
if r.scheme == "https"
    s = 1
end

hostRow = db.execute("select hostname_id, to_https, to_domain, status from hostname where from_https = ? AND from_domain = ?", s, r.hostname).next

if hostRow
    # 無効なので
    if hostRow[3] == 0
        Nginx.return Nginx::DECLINED
        return
    end

    toScheme = "http"
    if hostRow[1] == 1
        toScheme = "https"
    end

    # トップのみリダイレクト
    toHost = "#{toScheme}://#{hostRow[2]}"
    if hostRow[3] == 2
        Nginx.redirect toHost, code
        return
    end

    pageRow = db.execute("select to_path from page where hostname_id = ? AND from_path = ?", hostRow[0], r.uri).next
    if pageRow
        Nginx.redirect "#{toHost}#{pageRow[0]}", code
        return
    else
        Nginx.redirect toHost, code
        return
    end
else
    # 該当がない
    Nginx.return Nginx::DECLINED
    return
end
hostRow.close


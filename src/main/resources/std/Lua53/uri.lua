---
--- @param URI_string @ a Uniform Resource Identifier
--- @return table @ URI-components-table. Possible components are fragment, host, login, password, path, query, scheme, service.
function uri.parse(URI_string) end

---
--- @param URI_components_table @ a series of name:value pairs, one for each component
--- @param include_password @ boolean. If this is supplied and is true, then the password component is rendered in clear text, otherwise it is omitted.
--- @return string @ URI-string. Thus uri.format() is the reverse of uri.parse().
function uri.format(URI_components_table, include_password) end

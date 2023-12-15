function Meta (meta)
  if meta["readings"] then
    local entries = {}
    for i, entry in pairs(meta["readings"]) do
      key = entry["key"]
      description = entry["description"]
      url = entry["url"]
      if entry[1] then
        key = entry[1]
      end
      key = pandoc.utils.stringify(key)
      local out = key
      --if description then
      --  out = out .. ": " .. pandoc.utils.stringify(description)
      --end
      if url then
        out = out .. " [[link]](" .. pandoc.utils.stringify(url) .. ")"
      end
      local bib = pandoc.utils.stringify(out)
      table.insert(entries, bib)
    end
    local joined = '+ @' .. table.concat(entries, '\n+ @')
    local refs = pandoc.read(joined).blocks
    --print(refs)
    meta["reading_string"] = refs
  end
  return meta
end

return {
  {Meta = Meta},
}
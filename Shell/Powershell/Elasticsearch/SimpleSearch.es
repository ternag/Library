GET /_search
{
  "query": {
    "bool": {
      "must": {
        "match_all":{}
      }
    }
  }
}
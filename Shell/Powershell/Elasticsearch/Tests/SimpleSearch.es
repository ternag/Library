### Just return all documents ###
POST /_search
{
  "query": {
    "bool": {
      "must": {
        "match_all":{}
      }
    }
  }
}
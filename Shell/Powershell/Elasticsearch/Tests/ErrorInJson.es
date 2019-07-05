POST /_search
{
  "query": {
    "bool": {
      "must": {
        "match_all":#{octo-variable}
      }
    }
  }
}
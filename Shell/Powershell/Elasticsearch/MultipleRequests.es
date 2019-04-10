

GET /_search/1
{
  "query": {
    "bool": {
      "must": {
        "match_all":{}
      }
    }
  }
}

GET /_search/2
{
  "query": {
    "bool": {
      "must": {
        "match_all":{}
      }
    }
  }
}

Get /index/doc/34


GET /_search/3
{
  "query": {
    "bool": {
      "must": {
        "match_all":{}
      }
    }
  }
}
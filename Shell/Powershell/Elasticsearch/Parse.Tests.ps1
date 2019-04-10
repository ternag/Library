. ./Parse.ps1

Describe 'Ensure-StartsWithSlash' {
  $inputList = "_search","/_search"

  foreach ($input in $inputList)
  {  
    $actual = Ensure-StartsWithSlash -InputValue $input

    it "should return string starting with a slash. Input: '$input'" {
      $actual | Should -Be "/_search"
    }
  }
}

Describe 'Get-HttpMethod: positives' {
  $ValidHttpMethods = @('GET', 'POST', 'PUT', 'DELETE')

  $inputList = "GET _search"," POST /_search", "GET", "get", "POST", "post", "delete", "DELETE", "put", "PUT", "       PUT jsdfhglkjshdfg"

  foreach ($input in $inputList)
  {
    $actual = Get-HttpMethod $input
    it "should return http method '$input'='$actual'" {
      $actual | Should -BeIn $ValidHttpMethods
    }
  }
}

Describe 'Get-HttpMethod: fails' {
  $HttpMethodInputList = " PET /_search", "", "GET_search"

  foreach ($HttpMethodInput in $HttpMethodInputList)
  {
    it "should fail when the input does not start with a http method. Input='$HttpMethodInput'" {
      { Get-HttpMethod $HttpMethodInput } | should -Throw
    }
  }
}

Describe 'Get-PathQuery: positives' {
  $pathQueryInputList = ("  GET _search   ", "_search"), 
  (" POST /_search ", "/_search"), 
  ("GET /st-msg/messagesearchdto/_search?typed_keys=true", "/st-msg/messagesearchdto/_search?typed_keys=true")

  foreach ($pathQueryInputAndExpected in $pathQueryInputList)
  {
    $expected = $pathQueryInputAndExpected[1]
    $actual = Get-PathQuery $pathQueryInputAndExpected[0]
    it "should return expected path and query '$expected'" {
      $actual | should -Be $expected
    }
  }
}

Describe 'Get-PathQuery: fails' {
  $pathQueryInputList = "GET", "", "GET_search"

  foreach ($pathQueryInput in $pathQueryInputList)
  {
    it "should fail when the input does not contain a path/query. Input='$pathQueryInput'" {
      {Get-PathQuery $pathQueryInput} | should -Throw
    }
  }
}

Describe 'Read-Request' {
  it 'should return 4 requests' {
    $file = Get-Content .\MultipleRequests.es
    $requests = Group-Lines $file
    $requests.Length | should -Be 4
  }
}

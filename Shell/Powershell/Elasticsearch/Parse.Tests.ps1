. ./Parse.ps1

Describe 'Ensure-StartsWithSlash' {
  $inputList = "_search","/_search"

  foreach ($input in $inputList)
  {  
    $actual = Ensure-StartsWithSlash -InputValue $input

    it "should return string starting with a slash. Input: '$input'" {
      $actual | should be "/_search"
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
      $actual | should -BeIn $ValidHttpMethods
    }
  }
}

Describe 'Get-HttpMethod: fails' {
  $HttpMethodInputList = " PET /_search", "", "GET_search"

  foreach ($HttpMethodInput in $HttpMethodInputList)
  {
    it "should fail if input does not start with a http method. Input='$HttpMethodInput'" {
      $sb = "Get-HttpMethod '$HttpMethodInput'"
      [scriptblock]::Create($sb) | should -Throw
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
    it "should fail if input does not start with a http method. Input='$pathQueryInput'" {
      $sb = "Get-PathQuery '$pathQueryInput'"
      [scriptblock]::Create($sb) | should -Throw
    }
  }
}

Describe 'test' {

  it 'should work' {
    $file = Get-Content .\MultipleRequests.es
    $file | Read-Request
  }
}
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

Describe 'Parse-Request' {
  it 'should parse single-line requests' {
    $input = ,"GET /index/doc/13"
    $actual = Read-Request $input
    $actual.Method | Should -Be "GET"
    $actual.PathQuery | Should -Be "/index/doc/13"
    $actual.Body | Should -Be ""
  }
  it 'should parse multi-line requests' {
    $input = "PUT /index/doc/17","{", "a: hello","}"
    $actual = Read-Request $input
    $actual.Method | Should -Be "PUT"
    $actual.PathQuery | Should -Be "/index/doc/17"
    $actual.Body | Should -Be "{ a: hello }"
  }
}

Describe 'Group-Lines' {
  # it 'MultipleRequests should return 4 groups' {
  #   $file = Get-Content .\MultipleRequests.es
  #   $requests = Group-Lines $file
  #   $requests.Length | should -Be 4
  # }
  # it 'Read-Request with MultipleRequests should parse 4 groups' {
  #   $file = Get-Content .\MultipleRequests.es
  #   $requests = Group-Lines $file
  #   $result = @($requests | ForEach-Object { Read-Request $_ })
  #   $result.Length | should -Be 4
  #   #$result | ForEach-Object { Write-Host $_ }
  # }
  it 'SimpleSearch should return 1 group' {
    $file = Get-Content .\SimpleSearch.es
    $groups = Group-Lines $file
    Write-Host "-> " $groups[0][0]
    Write-Host "-> " $groups[0][1]
    Write-Host "-> " $groups[0][2]
    Write-Host "-> " $groups[0][3]
    Write-Host "-> " $groups[0][4]
    Write-Host "-> " $groups.Length
    #rite-Host "-> " $groups
    $groups.Length | should -Be 1
  }
  # it 'Read-Request with SimpleSearch should parse 1 group' {
  #   $file = Get-Content .\SimpleSearch.es
  #   $requests = Group-Lines $file
  #   $result = @($requests | ForEach-Object { Read-Request $_ })
  #   #$result | ForEach-Object { Write-Host $_ }
  #   $result.Length | should -Be 1
    
  # }
}

Describe 'Parse-File' {
  # it 'Write multi-line result' {
  #   $tmp = Parse-File .\MultipleRequests.es
  #   $tmp | ForEach-Object { Write-Host $_ }
  # }
  # it 'Write single-line result' {
  #   $tmp = Parse-File .\SingleLine.es
  #   $tmp | ForEach-Object { Write-Host $_ }
  # }
  # it 'Write SimpleSearch result' {
  #   $tmp = Parse-File .\SimpleSearch.es
  #   $tmp | ForEach-Object { Write-Host $_ }
  # }
}
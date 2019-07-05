Remove-Module $PSScriptRoot/../posh-elastic.psd1
Import-Module $PSScriptRoot/../posh-elastic.psd1

InModuleScope posh-elastic {
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

Describe 'Read-Requests' {
  it 'Read-Request with MultipleRequests should parse 4 requests' {
    $file = Get-Content $PSScriptRoot/MultipleRequests.es
    $result = Read-Requests $file
    $result.Length | should -Be 4
  }
  it 'SimpleSearch should return 1 group' {
    $file = Get-Content $PSScriptRoot/SimpleSearch.es
    $groups = Read-Requests $file
    $groups.Length | should -Be 1
  }
  it 'test Read-Request' {
    $lines = Get-Content $PSScriptRoot/ErrorInJson.es
    $req = Read-Request $lines
    Write-Host $req.Body
  }
}

Describe 'Read-EsFile' {
  it 'Write multi-line result' {
    $tmp = Read-EsFile $PSScriptRoot/MultipleRequests.es
    $tmp | ForEach-Object { Write-Host $_ }
  }
  it 'Write single-line result' {
    $tmp = Read-EsFile $PSScriptRoot/SingleLine.es
    $tmp | ForEach-Object { Write-Host $_ }
  }
  it 'Write SimpleSearch result' {
    $tmp = Read-EsFile $PSScriptRoot/SimpleSearch.es
    $tmp | ForEach-Object { Write-Host $_ }
  }
}
}
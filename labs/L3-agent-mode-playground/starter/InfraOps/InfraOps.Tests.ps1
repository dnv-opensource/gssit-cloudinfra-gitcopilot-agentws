BeforeAll {
    $modulePath = Join-Path $PSScriptRoot 'InfraOps.psm1'
    Import-Module $modulePath -Force
}

Describe 'Get-RetentionDays' {
    It 'returns integers for supported environments' {
        (Get-RetentionDays -Environment dev) | Should -BeOfType [int]
        (Get-RetentionDays -Environment test) | Should -BeOfType [int]
        (Get-RetentionDays -Environment prod) | Should -BeOfType [int]
    }

    It 'dev returns 7 days' {
        Get-RetentionDays -Environment dev | Should -Be 7
    }

    It 'test returns 30 days' {
        Get-RetentionDays -Environment test | Should -Be 30
    }

    It 'prod returns 365 days' {
        Get-RetentionDays -Environment prod | Should -Be 365
    }

    It 'matching is case-insensitive' {
        Get-RetentionDays -Environment DEV | Should -Be 7
    }

    It 'unknown environment is rejected' {
        { Get-RetentionDays -Environment qa } | Should -Throw
    }
}

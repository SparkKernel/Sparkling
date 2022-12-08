-- This is a testing-file
-- This is hard-coded asf (bc its for testing lol)

RegisterCommand('tst', function(source)
    local User = Sparkling.Users.Get(source)
    User.NUI.Clipboard:Copy('tesasddt')
end)
fileList = file.list()
print(type(fileList))

for name,size in pairs(fileList) do
    print("File name: "..name.." with size of "..size.." bytes")
end

fobjw = file.open('samplefile.txt','w')
fobjw:writeline('IoT first string')
fobjw:write('second string')
fobjw:write('third string')
print(fobjw.read())
print(fobjw.readline())

fobjr = file.open('samplefile.txt','r')
fobjr:writeline('IoT first string')
fobjr:write('second string')
fobjr:write('third string')
print(fobjr.readline())
fobjr:close()

fobjr = file.open('samplefile.txt','r')
print(fobjr.read())
print(fobjr.read())
fobjr:close()
fobjr = file.open('samplefile.txt','r')
print(fobjr.read())

fobjr:close()
fobjr = file.open('samplefile.txt','r')
print(fobjr.seek("cur",11))

print(fobjr.read())

print(fobjr.seek("cur",-5))

print(fobjr.read())
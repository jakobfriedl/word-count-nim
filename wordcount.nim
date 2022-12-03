import tables, os, strutils, sequtils, re, sugar, times, algorithm

# IO Functions, these cannot be pure by nature
proc getFiles(dir: string, ext: string): seq[string] = 
    for path in walkDirRec(dir): 
        if path.endsWith(ext): 
            result.add(path)

proc writeCounts(counts: seq[tuple[word: string, count: int]]) = 
    var file = open("out.txt", fmWrite)
    for item in counts: 
        file.writeLine($item.count & " " & item.word)
    file.close()

# The func keyword in nim describes a function without side-effects
func parse(contents: seq[string]): seq[string] = 
    contents.map(x => x.toLowerAscii()
                        .replace("\n", " ")
                        .replace(re"[^a-zA-Z0-9 ]", ""))
                        .join(" ").split(" ")
                        .filter(x => not x.isEmptyOrWhitespace)

func count(contents: seq[string]): seq[tuple[word: string, count: int]] = 
    var counts: CountTable[string]
    for word in contents: 
        counts.inc(word)
    for word, count in counts.pairs:
        result.add((word, count))
    result.sortedByIt((it.count, it.word)).reversed()

proc main() = 
    if(commandLineParams().len != 2):
        echo "Usage: nim c -r wordcount.nim <directory> <extension>"
        quit(1)
    
    let 
        dir: string = os.getCurrentDir() & "/" & commandLineParams()[0]
        ext: string = commandLineParams()[1]

    let start = times.now()

    let contents = getFiles(dir, ext).map(readFile)
    writeCounts(count(parse(contents)))

    echo "Finished: ", times.now() - start

when isMainModule:
    main()
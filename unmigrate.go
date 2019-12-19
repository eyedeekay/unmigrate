package main

/*
This is a tool that un-migrates config files that were migrated by i2ptunnel
in i2p version 0.9.42, which you should only need if you are moving from a
regular router installation to a portable router installation.
*/

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

var (
	dir = flag.String("dirpath", "./", "path to look for the file")
	out = flag.String("outpath", "./i2ptunnel.config", "path to save the un-migrated config file")
)

func main() {
	flag.Parse()
	files := GetDirContents(*dir)
	unMigrated := CombineDirContents(files)
	ioutil.WriteFile(*out, []byte(unMigrated), 0644)
	fmt.Println(unMigrated)
}

func GetDirContents(dirPath string) []string {
	if !strings.HasSuffix(dirPath, "/") {
		dirPath += "/"
	}
	log.Println("unmigrating", dirPath)

	var filelist []string
	files, err := ioutil.ReadDir(dirPath)
	if err != nil {
		log.Fatal(err)
	}

	for _, file := range files {
		if strings.HasSuffix(file.Name(), ".config") {
			filelist = append(filelist, dirPath+file.Name())
		}
	}
	return filelist
}

func UnmigrateConfigFile(index int, contents []byte) string {
	lines := strings.Split(string(contents), "\n")
	var unMigratedContents string
	for _, line := range lines {
		if line != "" {
			if !strings.HasPrefix(strings.TrimLeft(line, " "), "#") {
				unMigratedContents += "\ntunnel." + strconv.Itoa(index) + "." + line
			} else {
				unMigratedContents += "\n" + line
			}
		} else {
			unMigratedContents += "\n" + line
		}

	}
	return unMigratedContents
}

func CombineDirContents(files []string) string {
	var unMigratedFile string
	for index, file := range files {
		contents, err := ioutil.ReadFile(file)
		if err != nil {
			log.Fatal(err)
		}
		unMigratedFile += UnmigrateConfigFile(index, contents)
	}
	return unMigratedFile
}

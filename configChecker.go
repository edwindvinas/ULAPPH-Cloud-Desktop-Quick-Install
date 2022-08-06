package main

import (
        "fmt"
        "github.com/jinzhu/configor"
        "os"
        "sort"
)

var Config = struct {
        Project []struct {
                Name  string
                Date string
                Appid string
        }
        Installer []struct {
                Dir  string
        }
        Configs []struct {
                Item  string
                Format string
                Status string
                Value string
        }
}{}

type ConfigItem struct {
    Item  string
    Format string
    Status string
    Value string
}

// ConfigSorter sorts Config.Configs by Item.
type ConfigSorter []ConfigItem

func (a ConfigSorter) Len() int           { return len(a) }
func (a ConfigSorter) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ConfigSorter) Less(i, j int) bool { return a[i].Item < a[j].Item }

func main() {

    if len(os.Args) != 3 {
        fmt.Println("ERROR: Invalid command.")
        fmt.Println("TRY: configChecker total <CONFIG_FILE>")
        fmt.Println("TRY: configChecker list <CONFIG_FILE>")
    }
    totConfigs := 0
    MODE := os.Args[1] 
    CFG_FILE := os.Args[2] 
    switch MODE {
        case "total":
            //fmt.Println(CFG_FILE)
            //Load the configuration file
            configor.Load(&Config, CFG_FILE)
            //for _, cfg := range Config.Configs {
            for _, _ = range Config.Configs {
                //fmt.Println(cfg.Item)
                totConfigs++
            }
            fmt.Println(totConfigs)
        case "list":
            fmt.Println("*************************************************")
            fmt.Println("*************************************************")
            //Load the configuration file
            configor.Load(&Config, CFG_FILE)
            var configItems []ConfigItem
            for _, cfg := range Config.Configs {
                p := ConfigItem {
                    Item: cfg.Item, 
                    Format: cfg.Format, 
                    Status: cfg.Status,
                    Value: cfg.Value, 
                }
                configItems = append(configItems, p)
                //totConfigs++
            }
            sort.Sort(ConfigSorter(configItems))
            for _, cfg := range configItems {
                //fmt.Println(cfg.Item+" = "+cfg.Status+"\n")
                fmt.Println(cfg.Item)
            }
            //fmt.Println(totConfigs)
            fmt.Println("*************************************************")
            fmt.Println("*************************************************")
        default:
            fmt.Println("ERROR: Invalid mode")
    }
}

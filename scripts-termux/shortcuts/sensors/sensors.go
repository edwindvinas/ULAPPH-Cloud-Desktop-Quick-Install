package main

import (
	"fmt"
    "time"
    "context"
    tm "github.com/eternal-flame-AD/go-termux"
)

const (
    NUM_PROBE_INTERVAL=10
    NUM_BRIGHTNESS_DARK=0
    NUM_BRIGHTNESS_LIGHT=20
    STR_LOC_SOURCE tm.LocationProvider = "network"
)

//termux-location -p network -r once
func termuxLocation(c context.Context, ch chan string, p tm.LocationProvider) {
        if locjson, err := tm.Location(c, p); err != nil {
                //ch <- fmt.Sprintf("ERROR: %v\n", err)
                //panic(err)
        } else {
                ch <- fmt.Sprintf("%v", locjson)
        }
}

//termux-brightness
func termuxSetBrightness(ch chan string, b uint8) {
        if err := tm.Brightness(b); err != nil {
                //ch <- fmt.Sprintf("ERROR: %v\n", err)
                //panic(err)
        } else {
                ch <- fmt.Sprintf("%v", b)
        }
}

//termux-battery-status
func termuxBatteryStatus(ch chan string) {
        if stat, err := tm.BatteryStatus(); err != nil {
                //ch <- fmt.Sprintf("ERROR: %v\n", err)
                //panic(err)
        } else {
                //fmt.Printf("The current battery percentage is %d%%.\n", stat.Percentage)
                ch <- fmt.Sprintf("%d", stat.Percentage)
        }
}

func main() {
    c := context.Background()
    //Channels
    chTermuxBatteryStatus := make(chan string, 1)
    chTermuxSetBrightness := make(chan string, 1)
    chTermuxLocation := make(chan string, 1)
    //chTermuxSensorProximity := make(chan string, 1)
    chTermuxSensorProximity := make(chan []byte, 1)
  
    ticker := time.NewTicker(NUM_PROBE_INTERVAL * time.Second)
    //quit := make(chan struct{})
        for {
           select {
            case <- ticker.C:
                go termuxSetBrightness(chTermuxSetBrightness, NUM_BRIGHTNESS_DARK)
                go termuxBatteryStatus(chTermuxBatteryStatus)
                go termuxLocation(c, chTermuxLocation, STR_LOC_SOURCE)

            case thisValue := <- chTermuxBatteryStatus:
                fmt.Printf("TermuxBatteryStatus: %v \n", thisValue)

            case thisValue := <- chTermuxLocation:
                fmt.Printf("TermuxLocation: %v \n", thisValue)

            case thisValue := <- chTermuxSetBrightness:
                fmt.Printf("TermuxSetBrightness: %v \n", thisValue)
            //case <- quit:
                //ticker.Stop()
                //return
            }
        }
}

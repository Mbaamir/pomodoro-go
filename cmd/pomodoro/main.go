package main

import (
	"fmt"

	"github.com/spf13/viper"
)

func main() {
	// Set the file name of the configurations file
	viper.SetConfigFile("config.env")

	// Attempt to read the config file
	if err := viper.ReadInConfig(); err != nil {
		fmt.Printf("Error reading config file, %s", err)
	}

	// Set the key to be fetched
	pgURI := viper.GetString("PG_URI")

	// Use the value
	fmt.Printf("PostgreSQL URI: %s\n", pgURI)
}

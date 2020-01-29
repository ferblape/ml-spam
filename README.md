# ML Spam

This repository contains some scripts to download spam emails from http://untroubled.org/spam/ archive and convert them in a CSV suitable for training ML models.

## Setup

1. Install Ruby
2. Run `bundle install`
3. Check if you have `7z` installed. Otherwise install it

## How it works

There are two actions:

- `ruby actions/fetch_data.rb` to download the latest data. Data is cached in `data/` folder

- `ruby actions/export_jsonl.rb` to export the JSONLs of the downloaded data in `output/` folder


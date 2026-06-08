# To copy all JSON Reference data to same location:
aws s3 cp . s3://de0526-youtube-stats-useast1-dev/youtube/raw_stat_ref_data/ --recursive --exclude "*" --include "*.json"

# To copy all data files to its own location, following Hive-style patterns:
aws s3 cp CAvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=ca/
aws s3 cp USvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=us/
aws s3 cp RUvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=ru/
aws s3 cp MXvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=mx/
aws s3 cp GBvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=gb/
aws s3 cp INvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=in/
aws s3 cp JPvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=jp/
aws s3 cp KRvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=kr/
aws s3 cp FRvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=fr/
aws s3 cp DEvideos.csv s3://de0526-youtube-stats-useast1-dev/youtube/raw_stats/region=de/

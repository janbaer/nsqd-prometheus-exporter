# Changelog

## 2.0.2 - 2023-02-01

- No longer panic when nsqd is not reachable. Will try again after defined interval
- Remove support for reading stats from nsqd older version 1.

## 2.0.1 - 2022-03-28

- Fix problem with accessing variables from multiple threads

## 2.0.0 - 2022-03-27

- Support for multiple nsqd urls
- Add healthcheck endpoint

# Haskell-Grep
My Haskell sub-implementation of the egrep CLI tool.

This is a project used to learn Haskell and implement interesting design techniques with lazy IO. It's not meant to replace egrep.


![][file-example-gif]

## Table of Contents

<!-- TOC -->
 - [Supported Flags](#flags)
 - [Timing Comparisons](#timing)
 - [Interesting Design Features](#features)
 - [Benefits over egrep?](#benefits)
 - [Tasks](#tasks)

<!-- /TOC -->

## Supported CL Flags <a name="flags"></a>

Currently the implemented command line options are:

  - [-r | --recursive]
    - Recursively search for given pattern down directory tree(s)
  - [-h | --help]
    - Display usage and options

## Timing Comparisons <a name="timing"></a>

The timings and outputs of both haskellGrep and egrep when run recursively on this projects `src/` directory are displayed below:

![][haskell-timing-img]
![][egrep-timing-img]

However, the disparity in runtime grows much larger when both programs are executed recusively from my systems home/user directory:

```sh
./haskellGrep 'hello|world' -r ~/ 147.47s user 8.98s system 77% cpu 3:20.60 total

egrep 'hello|world' -r ~/ --color  3.99s user 1.42s system 86% cpu 6.233 total
```

## Interesting Design Features <a name="features"></a>
  - Uses Lazy IO Streaming for directory searches
  - Uses Lazy ByteStrings for file and stdin reading

  This program is written in roughly four independent blocks:

   - Recursively searching directory tree and attaining all file names to be processed (if -r is provided)
   - Extracting the text from all files
   - Parsing all the retrieved text and returning all matching instances
   - Printing out all matches

  This allowed each block to act independently in its operations and prevented tight coupling between the sections. 

  At first glance this style seems counterproductive as the user would need to wait for all processing to complete before seeing output.
  However, by leveraging Haskell's lazy by default processing, lazy string reading, and lazy IO streaming, this program behaves reactively similar to the original grep, with each file immediately displaying matched lines to the user, all while reaping the benefits of being programmed in a more concise fashion.

  
## Are there any external benefits over egrep? <a name="benefits"></a>
Nope. 

This is simply a mini-project written to practice Haskell and explore an intresting design technique.

This implementation only implements some of egreps core functionality and doesn't even have half of the features grep provides.
  
## Tasks
### Complete
* Text phrase match highlighting [DONE]
* Implement Lazy ByteStrings for file reading  [DONE]
* Implement IO Streaming for efficient directory searching [DONE]
* Implement Command Line Flags [DONE]
* Implement reading from STDIN when files are not provided [DONE]

### TODO
* Add Unit Tests


[file-example-gif]: readme_resources/haskellGrep_file_example.gif
[egrep-timing-img]: readme_resources/egrep_src_timing.png
[haskell-timing-img]: readme_resources/haskellGrep_src_timing.png

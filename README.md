The package **PBSmapx**, which is short-hand notation for _PBS Map Explore_, provides a convenient Graphical User Interface (GUI) tool for interacting with **PBSmapping**. The primary mapping function `createMap` presents a menu system for plotting topographical files as well as output from gridding and summary routines for geo-referenced data such as catch, effort, and catch per unit effort (CPUE). The underlying R code is somewhat convoluted; however, the user can largely ignore the code and simply manipulate the entries in the GUI menu. Though designed for users at the Pacific Biological Station (PBS), the GUI has proven useful for users at other locales. 

**PBSmapx** depends on the R package **PBStools**, which in turn depends on four other R packages: **PBSmapping**, **PBSmodelling**, **PBSdata**, and **RODBC**. We use **PBSmodelling** to implement the GUI. Originally, **PBSmapx** evolved over time (2007-2012) within the R package **PBSfishery**, along with useful datasets (regional boundaries, key codes, example data) and handy utility functions. In April 2012, we decided to split **PBSfishery** into three separate libraries -- **PBSmapx**, **PBSdata**, and **PBStools** -- for public distribution (see <http://github.com/pbs-software>). The three packages experience different levels of change, with **PBStools** undergoing frequent revision, while **PBSdata** and **PBSmapx** remain unchanged for long periods of time.
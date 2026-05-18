# Data visualisation in Observable Notebook
Link to Observable Notebook: https://observablehq.com/@computer-science-notts/sailor-shift-q2 


# Sailor Shift: Oceanus Folk Influence Analysis (Question 2)

[cite_start]An interactive visual analytics system designed to explore and map the cultural, temporal, and structural influence of the musical entity **Oceanus Folk**[cite: 347, 393]. [cite_start]Built inside an Observable notebook environment using advanced data visualization paradigms (including Streamgraphs, Sankey diagrams, Chord diagrams, and Radial Ego-Networks), this project answers complex inquiries regarding how musical inspiration propagates over time across genres and individual artists[cite: 326, 331, 394, 426, 469].


## 1. Underlying Dataset & Graph Schema

[cite_start]The project is driven by a synthetic dataset representing a complex ecosystem of musical influence and popularity metrics[cite: 256, 257, 271]. 

### Graph Architecture
* [cite_start]**Format:** JSON file (`data.json`) generated via Python's `networkx.node_link_data()` function, structured to seamlessly parse back into a NetworkX graph object[cite: 261, 268, 269].
* [cite_start]**Graph Type:** Directed Multigraph[cite: 263].
* [cite_start]**Scale:** Contains **17,412 nodes**, **37,857 edges**, and **18 connected components**[cite: 263, 264, 265].
* [cite_start]**Data Sources:** Compiled by combining a crowdsourced repository of manually notated musical influence (samples, covers, inspirations) with aggregate song popularity/record chart data curated by journalist Silas Reed[cite: 271, 272, 273].

### [cite_start]Schema Definitions [cite: 275]

#### [cite_start]Node Types & Attributes [cite: 266, 276]
* [cite_start]**Person:** Industry individuals (singers, producers, composers, instrumentalists) with properties: `name`, `stage_name`[cite: 277, 278, 279, 280].
* [cite_start]**MusicalGroup:** Formed bands, quartets, and officially organized collectives with properties: `name`[cite: 281, 282, 283].
* [cite_start]**Record Label:** Operational entities coordinating production, recording, or distribution with properties: `Name`[cite: 284, 285, 286, 287].
* [cite_start]**Song:** Standalone tracks or album tracks with properties: `single` (boolean), `genre`, `notable` (charted status), `release_date`, `notoriety_date`, `written_date`[cite: 288, 290, 291, 292, 295, 296, 297].
* [cite_start]**Album:** Full-length records with properties: `genre`, `notable`, `release_date`, `notoriety_date`, `written_date`[cite: 298, 300, 301, 302, 303].

#### [cite_start]Edge Types (Relationships) [cite: 266, 304]
* [cite_start]**Creative Credits:** `Performer Of`, `Composer Of`, `Producer Of`, `Lyricist Of`[cite: 266, 306, 310, 311, 313].
* [cite_start]**Industry Context:** `Recorded By`, `Distributed By`, `Member Of`[cite: 266, 314, 315, 323].
* [cite_start]**Lineage & Influence:** `InStyle Of`, `Interpolates From`, `CoverOf`, `LyricalReferenceTo`, `DirectlySamples`[cite: 266, 316, 317, 319, 320, 321].


## 2. Visualization System Design & Results

[cite_start]To investigate Question 2 fully, the dashboard is divided into targeted sub-questions using coordinated, interactive views[cite: 325, 327, 329, 393, 467].

### [cite_start]Sub-question 1: Was this influence intermittent or did it have a gradual rise? [cite: 327]

#### [cite_start]Visual Strategy [cite: 328]
* [cite_start]**Stacked Area Chart (Raw Counts):** Used as an initial baseline overview to surface precise yearly counts across genres[cite: 330, 333].
* [cite_start]**Streamgraph (Smoothed Macro-Trend):** Employs Byron and Wattenberg’s wiggle offset coupled with a **3-year rolling average** to damp down yearly visual noise and bring out micro-trends[cite: 331, 334].
* [cite_start]**Small Multiples:** Isolates individual genres on independent scales, avoiding the baseline distortion inherent to stacked layouts[cite: 330].
* [cite_start]**Chord Diagram (Era Overviews):** Maps how genres blend dynamically into Oceanus Folk, utilizing interactive filtering across discrete eras relative to the *Sailor Shift* breakthrough[cite: 469, 476, 477].

[insert figure 1 here]  
*Figure 1: Coordinated Streamgraph and Small Multiples showing temporal influence volume.*

#### Analytical Findings
* [cite_start]**Intermittent vs. Gradual:** The raw data displays highly volatile, intermittent bursts with massive isolated spikes occurring in **2017, 2023, and 2029**[cite: 333]. [cite_start]However, the rolling-average streamgraph surfaces a underlying long-term trend: a gradual, cumulative cultural wave that steadily builds forward from **2019**[cite: 331, 335].
* [cite_start]**Inspiration Eras (Chord Analysis):** * **Legacy Era (Pre-2023):** Oceanus Folk roots relied heavily on solid foundations in *Indie Folk* (17 works) and *Synthwave* (15 works)[cite: 480, 489].
  * [cite_start]**Emergence Era:** Inspiration shifted towards a tighter grouping of *Dream Pop* (7), *Indie Folk* (5), and *Doom Metal* (4)[cite: 481].
  * [cite_start]**Contemporary Era:** Heavy structural reliance on fixed core genres completely dissolved, fragmenting into minimal, highly distributed inspiration points (1 or 2 works each) spread evenly across *Desert Rock*, *Dream Pop*, and *Space Rock*[cite: 482, 483].

[insert figure 2 here]  
*Figure 2: Chord Diagram showing localized genre blending across eras.*

---

### [cite_start]Sub-question 2: What genres and top artists have been most influenced by Oceanus Folk? [cite: 393]

#### [cite_start]Visual Strategy [cite: 394]
* [cite_start]**Sankey Diagram:** Maps the directional flow of influence from Oceanus Folk outward through specific musical genres and splitting clean into destination work types (`Songs` or `Albums`)[cite: 395]. [cite_start]Ribbon widths encode quantitative influence counts[cite: 396].
* [cite_start]**Radial Ego-Network Diagram:** Replaces messy force-directed "hairballs" with a fixed, stable circular ring layout anchoring Oceanus Folk perfectly at the center[cite: 430, 432, 515, 516]. [cite_start]Node sizing scales with the total volume of influenced works[cite: 438].

[insert figure 3 here]  
*Figure 3: Sankey Diagram mapping the structural trajectory of influence.*

#### Analytical Findings
* [cite_start]**Top Genres:** The flow lines conclusively prove that **Dream Pop (29 works)**, **Indie Folk (28 works)**, and **Desert Rock (24 works)** represent the dominant categories absorbing Oceanus Folk's impact[cite: 404, 405].
* [cite_start]**Work Type Distribution:** Influence flows overwhelmingly into single **Songs (115)** compared to full-length **Albums (34)**[cite: 406].
* [cite_start]**Top Impacted Artists:** Ten distinct artists tie for peak influence, leading the network with three impacted works each[cite: 435]. [cite_start]Key standout entities include **Blazing Collective** and **Jonathan Diaz**[cite: 435].
* [cite_start]**Professional Roles:** Categorical link color-coding demonstrates that these core impacted targets are highly versatile individual professionals (represented by black nodes) operating multi-roles as composers, performers, lyricists, and producers simultaneously[cite: 436, 464].

[insert figure 4 here]  
*Figure 4: Radial Ego-Network anchoring central Oceanus Folk influence out to top artists.*


## 3. Technical Implementation & Coordinated Interactions

The environment incorporates core interaction design philosophies to handle information density smoothly:
* [cite_start]**Details-on-Demand (Sankey):** Implements custom click-to-expand behavior on nodes, allowing users to safely unravel top items inside high-density genres without flooding the structural canvas[cite: 397, 398]. [cite_start]Long tails of minor genres are auto-aggregated to sustain real-time performance[cite: 399].
* [cite_start]**Interactive Pan & Zoom (Ego-Network):** Combined with localized user selection menus to filter the exact numbers of top artists shown (15, 25, or 40), maintaining responsive frame rates and high structural visibility[cite: 424, 433].

# Sailor Shift: Oceanus Folk Influence Analysis (Question 2)

An interactive visual analytics system designed to explore and map the cultural, temporal, and structural influence of the musical entity **Oceanus Folk**. Built inside an Observable notebook environment using advanced data visualization paradigms (including Streamgraphs, Sankey diagrams, Chord diagrams, and Radial Ego-Networks), this project answers complex inquiries regarding how musical inspiration propagates over time across genres and individual artists.

---

## 1. Underlying Dataset & Graph Schema

The project is driven by a synthetic dataset representing a complex ecosystem of musical influence and popularity metrics. 

### Graph Architecture
* **Format:** JSON file (`data.json`) generated via Python's `networkx.node_link_data()` function, structured to seamlessly parse back into a NetworkX graph object.
* **Graph Type:** Directed Multigraph.
* **Scale:** Contains **17,412 nodes**, **37,857 edges**, and **18 connected components**.
* **Data Sources:** Compiled by combining a crowdsourced repository of manually notated musical influence (samples, covers, inspirations) with aggregate song popularity/record chart data curated by journalist Silas Reed.

### Schema Definitions

#### Node Types & Attributes
* **Person:** Industry individuals (singers, producers, composers, instrumentalists) with properties: `name`, `stage_name`.
* **MusicalGroup:** Formed bands, quartets, and officially organized collectives with properties: `name`.
* **Record Label:** Operational entities coordinating production, recording, or distribution with properties: `Name`.
* **Song:** Standalone tracks or album tracks with properties: `single` (boolean), `genre`, `notable` (charted status), `release_date`, `notoriety_date`, `written_date`.
* **Album:** Full-length records with properties: `genre`, `notable`, `release_date`, `notoriety_date`, `written_date`.

#### Edge Types (Relationships)
* **Creative Credits:** `Performer Of`, `Composer Of`, `Producer Of`, `Lyricist Of`.
* **Industry Context:** `Recorded By`, `Distributed By`, `Member Of`.
* **Lineage & Influence:** `InStyle Of`, `Interpolates From`, `CoverOf`, `LyricalReferenceTo`, `DirectlySamples`.

---

## 2. Visualization System Design & Results

To investigate Question 2 fully, the dashboard is divided into targeted sub-questions using coordinated, interactive views.

### Sub-question 1: Was this influence intermittent or did it have a gradual rise?

#### Visual Strategy
* **Stacked Area Chart (Raw Counts):** Used as an initial baseline overview to surface precise yearly counts across genres.
* **Streamgraph (Smoothed Macro-Trend):** Employs Byron and Wattenberg’s wiggle offset coupled with a **3-year rolling average** to damp down yearly visual noise and bring out micro-trends.
* **Small Multiples:** Isolates individual genres on independent scales, avoiding the baseline distortion inherent to stacked layouts.
* **Chord Diagram (Era Overviews):** Maps how genres blend dynamically into Oceanus Folk, utilizing interactive filtering across discrete eras relative to the *Sailor Shift* breakthrough.

[insert figure 1 here]  
*Figure 1: Coordinated Streamgraph and Small Multiples showing temporal influence volume.*

#### Analytical Findings
* **Intermittent vs. Gradual:** The raw data displays highly volatile, intermittent bursts with massive isolated spikes occurring in **2017, 2023, and 2029**. However, the rolling-average streamgraph surfaces an underlying long-term trend: a gradual, cumulative cultural wave that steadily builds forward from **2019**.
* **Inspiration Eras (Chord Analysis):** * **Legacy Era (Pre-2023):** Oceanus Folk roots relied heavily on solid foundations in *Indie Folk* (17 works) and *Synthwave* (15 works).
  * **Emergence Era:** Inspiration shifted towards a tighter grouping of *Dream Pop* (7), *Indie Folk* (5), and *Doom Metal* (4).
  * **Contemporary Era:** Heavy structural reliance on fixed core genres completely dissolved, fragmenting into minimal, highly distributed inspiration points (1 or 2 works each) spread evenly across *Desert Rock*, *Dream Pop*, and *Space Rock*.

[insert figure 2 here]  
*Figure 2: Chord Diagram showing localized genre blending across eras.*

---

### Sub-question 2: What genres and top artists have been most influenced by Oceanus Folk?

#### Visual Strategy
* **Sankey Diagram:** Maps the directional flow of influence from Oceanus Folk outward through specific musical genres and splitting clean into destination work types (`Songs` or `Albums`). Ribbon widths encode quantitative influence counts.
* **Radial Ego-Network Diagram:** Replaces messy force-directed "hairballs" with a fixed, stable circular ring layout anchoring Oceanus Folk perfectly at the center. Node sizing scales with the total volume of influenced works.

[insert figure 3 here]  
*Figure 3: Sankey Diagram mapping the structural trajectory of influence.*

#### Analytical Findings
* **Top Genres:** The flow lines conclusively prove that **Dream Pop (29 works)**, **Indie Folk (28 works)**, and **Desert Rock (24 works)** represent the dominant categories absorbing Oceanus Folk's impact.
* **Work Type Distribution:** Influence flows overwhelmingly into single **Songs (115)** compared to full-length **Albums (34)**.
* **Top Impacted Artists:** Ten distinct artists tie for peak influence, leading the network with three impacted works each. Key standout entities include **Blazing Collective** and **Jonathan Diaz**.
* **Professional Roles:** Categorical link color-coding demonstrates that these core impacted targets are highly versatile individual professionals (represented by black nodes) operating multi-roles as composers, performers, lyricists, and producers simultaneously.

[insert figure 4 here]  
*Figure 4: Radial Ego-Network anchoring central Oceanus Folk influence out to top artists.*

---

## 3. Technical Implementation & Coordinated Interactions

The environment incorporates core interaction design philosophies to handle information density smoothly:
* **Details-on-Demand (Sankey):** Implements custom click-to-expand behavior on nodes, allowing users to safely unravel top items inside high-density genres without flooding the structural canvas. Long tails of minor genres are auto-aggregated to sustain real-time performance.
* **Interactive Pan & Zoom (Ego-Network):** Combined with localized user selection menus to filter the exact numbers of top artists shown (15, 25, or 40), maintaining responsive frame rates and high structural visibility.

---

## 4. Design Reflection & Future Roadmap

* **Temporal Data Challenges:** Initial engineering attempts focused on raw multi-line trend plots. These caused massive visual clutter and overlapping line tangles. Transitioning to a decoupled model pairing a rolling-average streamgraph with multi-scale small multiples resolved the issue.
* **Relative Scale Limitations:** Current analysis utilizes absolute counts. To calculate an even truer picture of stylistic impact, future iterations should map relative normalization metrics, calculating the exact percentage of an artist's total discography that was influenced by Oceanus Folk.
* **AI-Driven Visual Analytics:** Future development could integrate real-time ML density models that autonomously simplify graph physics, intelligently bundling structural paths and collapsing edge densities dynamically to prevent cognitive overload.

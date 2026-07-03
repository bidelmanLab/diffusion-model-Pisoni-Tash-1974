**Diffusion Drift Model (DDM) Simulation of a 5-Step Speech Continuum (/ba/ to /pa/) 
(Pisoni & Tash, _Perception and Psychophysics_, 1974).**

Model inspired by:
Ratcliff, R., & McKoon, G. (2008). The diffusion decision model: Theory and data for two-choice decision tasks. Neural Computation, 20(4), 873–922.

Vowel vs. CV identification and reaction times for phoneme labeling tasks can be modelled using a noisy decision model that accumulates evidence over time. The so-called drift diffusion model (DDM) is one popular choice (Ratcliff and McKoon, 2008). The DDM assumes the accumulation of information (i.e., drift rate) is determined by the quality of information extracted from the stimulus. Ambiguous tokens have drift rates near zero, causing prolonged evidence accumulation; strong negative/positive drift rates are associated with faster evidence accumulation and thus shorter RTs. Model results show that the inverted-V vs. flatter RT pattern observed in empirical data for vowels vs. CVs (e.g., Bidelman et al., PloS One, 2025) is described by changes in drift rate. For vowels, slower accumulation of evidence occurs near the continuum midpoint (drift rate ~ 0) relative to endpoints (strong +/- drift rate), leading to more ambiguous identification and a slowing of the RT at Tk 3. For CVs, evidence accumulation is equally fast across the continuum (i.e., large and similar drift rates across all tokens) leading to invariant RTs.

Run the m-file to simulate the figures:

<img width="822" height="645" alt="simulations" src="https://github.com/user-attachments/assets/2c7b15fc-cf8a-4683-ab26-6e65cecf6193" />
<img width="1002" height="604" alt="image" src="https://github.com/user-attachments/assets/b10b86bd-b5dd-45a4-b897-faed4805d2b9" />


<img width="998" height="601" alt="image" src="https://github.com/user-attachments/assets/8f3e77ed-58b4-47c3-8ebc-8f5cf447ce05" />

**Diffusion Drift Model (DDM) Simulation of a 5-Step Speech Continuum (/ba/ to /pa/) 
(Pisoni & Tash, _Perception and Psychophysics_, 1974).**

Model inspired by:
Ratcliff, R., & McKoon, G. (2008). The diffusion decision model: Theory and data for two-choice decision tasks. Neural Computation, 20(4), 873–922.

<img width="400" alt="image" src="https://github.com/user-attachments/assets/edd3de72-4d23-42f9-9c7f-f5c992c0603b" />

  **Figure 1: The diffusion decision model (R&K, 2008)**
  


**Simulations of phoneme categorization:**

Vowel vs. CV identification and reaction times for phoneme labeling tasks can be modelled using a noisy decision model that accumulates evidence over time. The so-called drift diffusion model (DDM) is one popular choice (Ratcliff and McKoon, 2008). The DDM assumes the accumulation of information (i.e., drift rate) is determined by the quality of information extracted from the stimulus. Ambiguous tokens have drift rates near zero, causing prolonged evidence accumulation; strong negative/positive drift rates are associated with faster evidence accumulation and thus shorter RTs. Model results show that the inverted-V vs. flatter RT pattern observed in empirical data for vowels vs. CVs (e.g., Bidelman et al., PloS One, 2025) is described by changes in drift rate. For vowels, slower accumulation of evidence occurs near the continuum midpoint (drift rate ~ 0) relative to endpoints (strong +/- drift rate), leading to more ambiguous identification and a slowing of the RT at Tk 3. For CVs, evidence accumulation is equally fast across the continuum (i.e., large and similar drift rates across all tokens) leading to invariant RTs.

Run the m-file (pisoni_tash_RT_model.m) to simulate the figures:

<img width="500" alt="image" src="https://github.com/user-attachments/assets/2aa0956b-8c8f-4c11-be63-56ffb78a2d97" />
<img width="500" alt="image" src="https://github.com/user-attachments/assets/01236c64-ad6b-4d90-99d9-fcf3c14510d5" />



<img width="300"  alt="image" src="https://github.com/user-attachments/assets/b002416f-2088-4397-abc3-e1cdd9ac1f11" />

References:

Bidelman, G. M., Bernard, F., & Skubic, K. (2025). Hearing in categories and speech perception at the “cocktail party”. PloS One, 20(1), e0318600.

Pisoni, D. B., & Tash, J. (1974). Reaction times to comparisons within and across phonetic categories. Perception and Psychophysics, 15(2), 285–290. 

Ratcliff, R., & McKoon, G. (2008). The diffusion decision model: Theory and data for two-choice decision tasks. Neural Computation, 20(4), 873–922.



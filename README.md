GLM Pricing Model project

Link to full project - https://docs.google.com/spreadsheets/d/1MXsL0ZrhtfAWJgxyGWk1w-c1X88QzaPfzSqsrIPMj9Q/edit?gid=1817908966#gid=1817908966

Data from insuranceData R package - dataCar dataset

A Generalized Linear Model (GLM) is a statistical framework used to identify how different risk characteristics affect claim frequency and severity. This project is a GLM pricing model built using the dataCar dataset from the insuranceData R package, which contains approximately 68,000 vehicle insurance policies. I used R to fit a Poisson GLM to model claim frequency and a Gamma GLM to model claim severity using driver age, geographic area, vehicle age, vehicle body type, and gender as variables. I took the model coefficients and produced combined relativities showing how each risk characteristic increases or decreases expected claim costs relative to a base risk profile. These relativities were combined into rate tables and an individual risk pricer, allowing input of rating variables and an indicated annual premium will be calculated instantly.

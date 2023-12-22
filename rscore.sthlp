{smcl}
{* *! version 18.0 21dec2023}{...}
{viewerdialog rscore "dialog rscore"}{...}
{viewerjumpto "Syntax" "rscore##syntax"}{...}
{viewerjumpto "Description" "rscore##description"}{...}
{viewerjumpto "Options" "rscore##options"}{...}
{viewerjumpto "Examples" "rscore##examples"}{...}
{viewerjumpto "Author" "rscore##authors"}{...}

{p2col:{bf:rscore}}Rounded score 

{marker syntax}{...}
{title:Syntax}


{phang}{cmd:rscore} {cmd:,} [{opt name:(string)} {opt dec:imal(numlist)} {opt tab:ulation} {opt keep:cons} {opt replace:}]


{marker description}{...}
{title:Description}

{p 10 5 3}
	A rounded score creates a rounded-simplest scoring system for a specific purpose as a rule of thumb, calculation in the mental arithmetic by the user in an emergency condition or rapid decision-making from post-estimation output derived from regress ling to make it compatible with the following commands: "regress," "logistic," "logit," and "stcox." It is essential to note that when using ordinal logistic regression to construct an easy scoring system, you'll need one odds ratio for each variable. This simplifies rapid assessment by creating an additive score rounded to an integer for easy calculation. Each regression coefficient can then be converted into an integer or a specific decimal, such as 0.5. This approach is designed for bedside evaluation in emergencies, ensuring that the score is ready for immediate use and simple to calculate without relying on a computer or an application, similar to well-known tools like Alvarado score, Apgar score, Ottawa ankle rule, II, and Glasgow Coma Scale.

{p 10 5 3}
The rounded score extracts and round coefficient to the integer or 0.5 score. The zero efficient or i. dummy variable, categorical variables.  Algorithm comprise of 

{p 10 5 3}
1. Division: divide each coefficient by the smallest magnitude coefficient. Therefore, the division reserve direction is the negative coefficient.

{p 10 5 3}
2. Rounding: rounded the divided coefficient with a specific nearest integer.

{p 10 5 3}
3. Summation: sum the score to a Newvar variable. 

{p 10 5 3}
User-prespecify Newvar can build a wide range of decimal-rounded scores, building many easy-to-calculate scores.

{marker options}{...}
{title:Options}

{p2colset 10 25 25 3}{...}
{p2col:{opt name:(string)}}Specify the scoring system name. Default is score.{p_end}

{p2col:{opt dec:imal}}Specify the scoring system decimal digits. Default is zero, rounded to an integer.{p_end}

{p2col:{opt tab:ulation}}Express Predictors and rounded score table. Default is no show.{p_end}

{p2col:{opt keep:cons}}Keep the constant as one of the predictors. Default is exclude the constant term.{p_end}

{p2col:{opt replace:}}Substitute the previous sum score variable generate by rscore. Previous estimation will be deleted.  Default is warning the duplication of the score.{p_end}

{p2colreset}{...}

{marker examples}{...}
{title:Examples}

{p 5 5 3}
Import Hosmer & Lemeshow low birth weight example dataset

{phang2}{stata webuse lbw,clear: webuse lbw,clear}

{p 5 5 3}
Estimate logistic regression with potential predictors for low birth weight

{phang2}{stata logistic low i.race smoke i.ht i.ui: logistic low i.race smoke i.ht i.ui}

{p 5 5 3}
Immediately do after regression with specify name of the new score “lbwscore” predict the probability of low birth weight

{phang2}{stata rscore ,name(lbwscore) tabulation decimal(0.5): rscore ,name(lbwscore) tabulation decimal(0.5)}

{p 5 5 3}Determine discrimination index with AuROC by roctab

{phang2}{stata roctab low lbwscore ,graph detail: roctab low lbwscore ,graph detail}

{hline}

{marker author}{...}
{title:Author}

{p 10 5 3}
Suppachai Lawanaskol, MD{p_end}
{p 10 5 3}
Chaiprakarn hospital, Chiang Mai, Thailand{p_end}

{p 10 5 3}
Jayanton Patumanond, MD, DSc{p_end}
{p 10 5 3}
Center of Clinical Epidemiology and Clinical Statistics, Faculty of medicine, Chiang Mai University, Chiang Mai, Thailand{p_end}

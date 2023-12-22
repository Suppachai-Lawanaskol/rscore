*program drop rscore
***Suppachai Lawanaskol, MD***
program define rscore
	version 18.0
	syntax [, Name(string) Decimal(numlist) TABulation KEEPcons REPLACE]
	**Define variable name contain the derivation individual score**
	**Define the coefficient matrix**
	qui mat def coef=e(b)
	**Define the number of parameter, if not stcox decrease scalar number -1 for constant elimination**
	if "`e(cmd2)'"=="stcox"{
		local k : colsof r(table)
		scalar num=`k'
		local endpoint fail
		if "`keepcons'"==""{
			di _column(5) in red "Cox Semi parametric regression did not report the constant"
		}
	}
	else{
		if "`keepcons'"!=""{
			local k: colsof r(table)
			scalar num=`k'
			local endpoint `e(depvar)'
		}
		else{
			local k: colsof r(table)
			scalar num=`k'-1
			local endpoint `e(depvar)'
		}
	}
	
	**Round decimal**
	if "`decimal'"==""{
		local decimal "1"
	}
	
	**Name of score**
	if "`name'"==""{
		local name "score"
	}
	
	**Define the absolute cofficient matrix**
	qui mat def abscoef=J(1,`=scalar(num)',.)
	qui mat li abscoef

	**Convert to absolute**
	qui forvalues x=1/`=scalar(num)'{
		if coef[1,`x']<0{
			mat def abscoef[1,`x']=-coef[1,`x']
		}
		else{
			mat def abscoef[1,`x']=coef[1,`x']
		}
	}
	
	**Explore to check the absolute coefficient**
	qui mat li abscoef

	**Delete zero coefficient**
	forvalues x=1/`=scalar(num)'{
		if abscoef[1,`x']==0{
			mat def abscoef[1,`x']==.
		}
	}
	**Minimum values define intial values of min is infinity**
	qui scalar min=.

	forvalues x=1/`=scalar(num)'{
		if abscoef[1,`x']<`=scalar(min)'{
			scalar min=abscoef[1,`x']
		}	
	}
	**Define scalar min to be an divider**
	qui di `=scalar(min)'
	**Use coefficient / scalar min**
	qui mat def devcoef=coef/`=scalar(min)'
	qui mat li devcoef
	**Round up each coefficient**
	qui mat def roundcoef=J(1,`=scalar(num)',.)
	qui forvalues x=1/`=scalar(num)'{
		mat def roundcoef[1,`x']=round(devcoef[1,`x'],`decimal')
	}
	**Tabulation the rounded score**
	if "`tabulation'"!=""{
		di _column(5) in white "_________________________" _newline(1) _column(5) "Endpoint is `endpoint'"_newline(1) _column(5) "_________________________" _newline(1) ///
_column(5) "Predictors" _column(20) "`name'" _newline(1) ///
_column(5) "_________________________"
		forvalues x=1/`=scalar(num)'{
		di in white _column(5) "`: word `x' of `: colnames devcoef''" _column(20) in yellow roundcoef[1,`x']
		}
		di in white _column(5) "_________________________"
	}
	**Generate variable each predictors as _score**
	forvalues x=1/`=scalar(num)'{
		generate _`name'`x'=roundcoef[1,`x']*`: word `x' of `: colnames devcoef''
	}
	**Detect the variable score name**
	if "`replace'"!=""{
		capture confirm variable `name'
		if !_rc {
			di in red "`name' was deleted"
			drop `name'
		}
	}
	else{
		capture confirm variable `name'
		if !_rc {
			di in red "`name' already exists"
			drop _`name'*
		}
	}
	egen `name'=rowtotal(_`name'*)
	drop _`name'*
end



%-------------------------------------------------------
% Author: Sean Policarpio
% Date: 24.08.2012 21:29:47
%
% About: Based on a users circumstances, monthly expenses, and goals (monthly and end-of-term), this ASP program will determine what course of action the user should follow to achieve their goals.
%-------------------------------------------------------

% the program will read in a number of constants from the user
#const term = 6 %months

% a monthly expense which is always deducted every month
% strong_monthly_expense(dollar_amount).

% a monthly expense which is *sometimes* or *optionally* deductible
% weak_monthly_expense(dollar_amount, weight).

% a monthly goal which *must* be made - i.e. how much the user has to have at the end of the month
% strong_monthly_goal(dollar_amount).

% a monthly goal which would be *nice* to have - i.e. how much extra the user would like to have at the end of the month
% weak_monthly_goal(dollar_amount, weight).

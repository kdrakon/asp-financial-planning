%-------------------------------------------------------
% Author: Sean Policarpio
% Date: 24.08.2012 21:29:47
%
% About: Based on a users circumstances, monthly expenses, and goals (monthly and end-of-term), this ASP program will determine what course of action the user should follow to achieve their goals.
%-------------------------------------------------------

%-------------------------------------------------------
% Preliminaries
%-------------------------------------------------------

% the program will read in a number of constants from the user
#const termlength = 6. %months
months(1..termlength).
#hide months/1.
weight_scale(1..10). %the scale for weights of weak goals and expenses
#hide weight_scale/1.

% a monthly expense which is always deducted every month
% strong_monthly_expense(id, dollar_amount).
#hide strong_monthly_expense/2.

% a monthly expense which is *sometimes* or *optionally* deductible
% weak_monthly_expense(id, dollar_amount, weight).
#hide weak_monthly_expense/3.

% a monthly goal which *must* be made - i.e. how much the user has to have at the end of the month
% strong_monthly_goal(id, dollar_amount).
#hide strong_monthly_goal/2.

% a monthly goal which would be *nice* to have - i.e. how much extra the user would like to have at the end of the month
% weak_monthly_goal(id, dollar_amount, weight).
#hide weak_monthly_goal/2.

% the goal (balance) that must be achieved by the end of the term
% term_goal(dollar_amount).
#hide term_goal/1.

%-------------------------------------------------------
% Reasoning
%-------------------------------------------------------

% for each month of the term, add the strong expenses and goals
month_expense(MONTH_NUM, ID, AMOUNT) :- strong_monthly_expense(ID, AMOUNT), months(MONTH_NUM).
month_goal(MONTH_NUM, ID, AMOUNT) :- strong_monthly_goal(ID, AMOUNT), months(MONTH_NUM).

% for each weak monthly expense/goal, create a monthly expense/goal for at least zero to termlength
1{month_expense(MONTH_NUM, ID, AMOUNT) : months(MONTH_NUM)}termlength :- weak_monthly_expense(ID, AMOUNT, WEIGHT).
1{month_goal(MONTH_NUM, ID, AMOUNT) : months(MONTH_NUM)}termlength :- weak_monthly_goal(ID, AMOUNT, WEIGHT).

% compute each months balance based on the expenses and goals
% using clingo aggregates...

%-------------------------------------------------------
% Author: Sean Policarpio
% Date: 24.08.2012 21:29:47
%
% About: Based on a users circumstances, monthly expenses, and goals (monthly and end-of-term), this ASP program will determine what course of action the user should follow to achieve their goals.
%-------------------------------------------------------

%-------------------------------------------------------
% Constants
%-------------------------------------------------------
#const termlength = 2. %months


%-------------------------------------------------------
% Inputs
%-------------------------------------------------------

% the program will read in a number of constants from the user
months(1..termlength).
#hide months/1.

% a beginning balance
% beginning_balance(dollar_amount).
#hide beginning_balance/1.
% copy the beginning balance as the first passover amount
monthly_passover_balance(0, AMOUNT) :- beginning_balance(AMOUNT).

% a monthly revenue which is debited every month
% monthly_income(id, dollar_amount).
#hide monthly_income/2.

% a monthly expense which is always deducted every month
% strong_monthly_expense(id, dollar_amount).
#hide strong_monthly_expense/2.

% a monthly expense which is *sometimes* or *optionally* deductible
% weak_monthly_expense(id, dollar_amount).
#hide weak_monthly_expense/2.

% a monthly goal which *must* be made - i.e. how much the user has to have at the end of the month
% strong_monthly_goal(id, dollar_amount).
#hide strong_monthly_goal/2.

% a monthly goal which would be *nice* to have - i.e. how much extra the user would like to have at the end of the month
% weak_monthly_goal(id, dollar_amount).
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

% for each weak monthly expense/goal, either create a monthly expense/goal for it or not
num_of_weak_monthly_expenses(NUM) :- NUM := #count { weak_monthly_expense(ID, AMOUNT) }.
num_of_weak_monthly_goals(NUM) :- NUM := #count { weak_monthly_goal(ID, AMOUNT) }.

month_expense(MONTH_NUM, ID, AMOUNT) :- weak_monthly_expense(ID, AMOUNT), months(MONTH_NUM).
month_goal(MONTH_NUM, ID, AMOUNT) :- weak_monthly_goal(ID, AMOUNT), months(MONTH_NUM).

% compute the balance of the expenses for each month
total_expenses_per_month(MONTH_NUM, SUM) :- SUM := #sum [ month_expense(MONTH_NUM, ID, AMOUNT)=AMOUNT ], months(MONTH_NUM).

% compute the balance of the goals for each month
total_goals_per_month(MONTH_NUM, SUM) :- SUM := #sum [ month_goal(MONTH_NUM, ID, AMOUNT)=AMOUNT ], months(MONTH_NUM).

% compute the balance for each month
total_balance_per_month(MONTH_NUM, (INCOME+PASSOVER)-(GOALS+EXPENSES)) :- 
    monthly_income(ID, INCOME), total_goals_per_month(MONTH_NUM, GOALS), total_expenses_per_month(MONTH_NUM, EXPENSES), monthly_passover_balance(MONTH_NUM-1, PASSOVER),
    months(MONTH_NUM).

% compute the passover amount for a month
monthly_passover_balance(MONTH_NUM, PASSOVER) :- total_balance_per_month(MONTH_NUM, PASSOVER), months(MONTH_NUM).

% determine if the term goal is reachable or not




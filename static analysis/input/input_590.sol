uint256 public  monthlySalary;

function setMonthlySalary() public {
    monthlySalary= yearlySalary / months * conversionRate;
}



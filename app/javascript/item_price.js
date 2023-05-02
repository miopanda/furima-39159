function item_price (){
  const priceInput = document.getElementById("item-price");
  const tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  priceInput.addEventListener("input", (e) => {
    e.preventDefault();
    const inputValue = priceInput.value;
    const taxValue = Math.floor(inputValue / 10);
    tax.innerHTML = taxValue.toLocaleString();
    profit.innerHTML = (inputValue - taxValue).toLocaleString();
  });
  
};

window.addEventListener('load', item_price);

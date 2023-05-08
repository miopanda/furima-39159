function item_price (){
  const priceInput = document.getElementById("item-price");
  const tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const taxValue = Math.floor(inputValue / 10);
    tax.innerHTML = taxValue.toLocaleString('ja-JP', { maximumFractionDigits: 0 });
    profit.innerHTML = (inputValue - taxValue).toLocaleString('ja-JP', { maximumFractionDigits: 0 });
  });
  
};

window.addEventListener('load', item_price);

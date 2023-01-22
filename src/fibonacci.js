function fibonacci(n) {
  if (n <= 1) {
    return n;
  }

  return fibonacci(n - 1) + fibonacci(n - 2);
};

[
  [[0], 0],
  [[1], 1],
  [[2], 1],
  [[3], 2],
  [[4], 3],
  [[5], 5],
  [[6], 8],
  [[7], 13],
  [[8], 21],
  [[9], 34],
  [[10], 55],
].forEach((scenario) => {
  const inputs = scenario[0];
  const want = scenario[1];
  const got = fibonacci(...inputs);
  console.assert(want === got, `with ${inputs}: ${want} === ${got}`);
})

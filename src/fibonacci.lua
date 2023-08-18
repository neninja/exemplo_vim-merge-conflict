local function fibonacci(n)
  -- ...
  return 0
end

local tdt = {
  { 0,  0 },
  { 1,  1 },
  { 2,  1 },
  { 3,  2 },
  { 4,  3 },
  { 5,  5 },
  { 6,  8 },
  { 7,  13 },
  { 8,  21 },
  { 9,  34 },
  { 10, 55 },
}

for _, scenario in ipairs(tdt) do
  local input = scenario[1]
  local want = scenario[2]
  local got = fibonacci(input)
  assert(got == want, "with " .. input .. ": " .. want .. " == " .. got);
end

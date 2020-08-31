count <- 0
n <-10000
for (i in rnorm(n,0,1))
{
  if ((i >= -1) & (i <= 1))
  {
    count <- count + 1
  }
}
count/n
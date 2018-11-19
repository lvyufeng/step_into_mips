int now()
{
int count;
asm volatile("mfc0 %0,$9":"=r"(count)); 
return count;
}

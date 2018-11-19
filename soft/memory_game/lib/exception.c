unsigned long get_epc(void)
{
    unsigned long n;
    asm(
        "mfc0 %0,$14\n\t"
        :"=r"(n)
        );
    return n;
}

unsigned long get_cause(void)
{
    unsigned long n;
    asm(
        "mfc0 %0,$13\n\t"
        :"=r"(n)
        );
    return n;
}

void exception(void)
{
    unsigned long n;
    printf("There is an exception!!\n");
    n=get_epc();
    printf("The epc is %x\n",n);
    n=get_cause();
    printf("The cause is %x\n",n);
    return;
}

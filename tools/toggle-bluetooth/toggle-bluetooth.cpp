#include <stdio.h>
#include <stdlib.h>
#include "string.h"

int main()
{
  char buf[256];
  FILE* file;
  bool enabled;

  /* Read Bluetooth state */
  file = fopen("/proc/acpi/ibm/bluetooth", "r");
  if (file == NULL) return -1;

  fscanf(file, "%s", buf);
  fscanf(file, "%s", buf);

  fclose(file);

  if      (strcmp(buf, "enabled")  == 0) enabled = true;
  else if (strcmp(buf, "disabled") == 0) enabled = false;
  else return -1;

  /* Toggle Bluetooth state */
  file = fopen("/proc/acpi/ibm/bluetooth", "w");
  if (file == NULL) return -2;

  if (enabled)
  {
    int nr = fprintf(file, "%s", "disable");
    fclose(file);
    if (nr != 7) return -3;
  }
  else
  {
    int nr = fprintf(file, "%s", "enable");
    fclose(file);
    if (nr != 6) return -4;
  }

  return 0;
}

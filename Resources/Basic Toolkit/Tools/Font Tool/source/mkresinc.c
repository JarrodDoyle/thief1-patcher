/******************************************************************************
 *    mkresinc.c
 *
 *    This file is part of DarkUtils
 *    Copyright (C) 2004 Tom N Harris <telliamed@whoopdedo.cjb.net>
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *****************************************************************************/
#include <stdio.h>

#undef MIN
#define MIN(a,b)  (((a)<(b))?(a):(b))

int main(int argc, char *argv[])
{
	FILE *fres, *finc;
	struct 
	{
		unsigned long sz1;
		unsigned long sz2;
	} head;
	size_t num;
	unsigned char buf[16];
	register int i;

	if (argc < 3)
		return 0;

	fres = fopen(argv[1], "rb");
	if (!fres)
		return 2;

	num = fread(&head, 1, sizeof(head), fres);
	if (num < sizeof(head))
	{
		fclose(fres);
		return 1;
	}
	fseek(fres, head.sz2 - sizeof(head), SEEK_CUR);
	num = fread(&head, 1, sizeof(head), fres);
	if (num < sizeof(head))
	{
		fclose(fres);
		return 1;
	}
	fseek(fres, head.sz2 - sizeof(head), SEEK_CUR);

	finc = fopen(argv[2], "w");
	if (!finc)
	{
		fclose(fres);
		return 2;
	}

	fprintf(finc, "static const char _fontdialog[] = {\n");

	while (head.sz1 != 0)
	{
		num = fread(buf, 1, MIN(head.sz1,16), fres);
		if (num == 0)
			break;
		fprintf(finc, "\t");
		for (i=0;i<num;i++)
		{
			fprintf(finc, "0x%02X,", buf[i]);
		}
		fprintf(finc, "\n");
		head.sz1 -= num;
	}
	fprintf(finc, "};\n");

	fclose(finc);
	fclose(fres);

	return 0;
}

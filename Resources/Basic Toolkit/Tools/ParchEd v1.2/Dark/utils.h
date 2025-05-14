/******************************************************************************
 *    utils.h
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

#ifndef DARK_UTILS_H
#define DARK_UTILS_H

#define UNUSED(v)	/* v */

#if defined(__GNUC__)
typedef unsigned long long uint64;
typedef signed long long sint64;
#else
typedef unsigned __int64 uint64;
typedef signed __int64 sint64;
#endif
typedef unsigned long	uint32;
typedef signed long		sint32;
typedef unsigned short	uint16;
typedef signed short	sint16;
typedef unsigned char	uint8;
typedef signed char		sint8;

/* Isn't it great how everyone can invent their own boolean data type? */
typedef unsigned long	Boolean;

#ifdef __cplusplus
inline uint64 make_ll(uint32 h, uint32 l)
{
	return (((uint64)h<<32)&((uint64)0xFFFFFFFF<<32))|((uint64)l&0xFFFFFFFF);
}
#else
#define make_ll(__h,__l)	\
		((((uint64)(__h)<<32)&((uint64)0xFFFFFFFF<<32))|((uint64)(__l)&0xFFFFFFFF))
#endif

#endif

/* Copyright © 2002 SN Systems Software Limited
 * All Rights Reserved
 * $Revision: 5 $
 * $NoKeywords: $
 */
SECTIONS {
	.text		ALIGN(128): { *(.text) *(.text.*) *(.gnu.linkonce.t*) }
	.data		ALIGN(128): { *(.data) *(.data.*) *(.gnu.linkonce.d*) *(.vutext) *(.vutext.*) *(.vudata) *(.vudata.*)}
	.rodata		ALIGN(128): { *(.rodata) *(.rodata.*) *(.gnu.linkonce.r*) }
	.rdata		ALIGN(128): { *(.rdata) *(.rdata.*) }
	.gcc_except_table ALIGN(128): { *(.gcc_except_table) }
	.lit8     	ALIGN(128): { *(.lit8) }
	.lit4      	ALIGN(128): { *(.lit4) }
	.sdata		ALIGN(128): { *(.sdata) *(.sdata.*) *(.gnu.linkonce.s.*) }
	.sbss		ALIGN(128): { *(.sbss) *(.sbss.*) *(.scommon) }
	.bss		ALIGN(128): { *(.bss) *(.bss.*) *(.vubss) *(.vubss.*) }
}


kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	c2813103          	ld	sp,-984(sp) # 8000cc28 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1e4070ef          	jal	ra,80007200 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <restoreContext>:

.global restoreContext
.align 4
restoreContext:

    csrw sscratch, a0
    80001000:	14051073          	csrw	sscratch,a0

    #A0 = TCB::running->context.kernelStackPointer
    ld a0, _ZN3TCB7runningE
    80001004:	0000c517          	auipc	a0,0xc
    80001008:	cfc53503          	ld	a0,-772(a0) # 8000cd00 <_ZN3TCB7runningE>
    ld a0, 24(a0)
    8000100c:	01853503          	ld	a0,24(a0)

    #Switch to user stack
    #and set ra to bodyWrapper
    ld ra, 1*8(a0)
    80001010:	00853083          	ld	ra,8(a0)
    ld sp, 2*8(a0)
    80001014:	01053103          	ld	sp,16(a0)


    #TCB::running->context.kernelStackPointer += 256
    mv a1, a0
    80001018:	00050593          	mv	a1,a0
    addi a1, a1, 256
    8000101c:	10058593          	addi	a1,a1,256
    sd a1, 0(a0)
    80001020:	00b53023          	sd	a1,0(a0)
    csrr a0, sscratch
    80001024:	14002573          	csrr	a0,sscratch
    sret
    80001028:	10200073          	sret
    8000102c:	00000013          	nop

0000000080001030 <_ZN5RISCV14supervisorTrapEv>:
.extern _ZN5RISCV20handleSupervisorTrapEv
.align 4
.global _ZN5RISCV14supervisorTrapEv
.type _ZN5RISCV14supervisorTrapEv, @function
_ZN5RISCV14supervisorTrapEv:
    context_save
    80001030:	14051073          	csrw	sscratch,a0
    80001034:	0000c517          	auipc	a0,0xc
    80001038:	ccc53503          	ld	a0,-820(a0) # 8000cd00 <_ZN3TCB7runningE>
    8000103c:	01853503          	ld	a0,24(a0)
    80001040:	f0050513          	addi	a0,a0,-256
    80001044:	00053023          	sd	zero,0(a0)
    80001048:	00153423          	sd	ra,8(a0)
    8000104c:	00253823          	sd	sp,16(a0)
    80001050:	00353c23          	sd	gp,24(a0)
    80001054:	02453023          	sd	tp,32(a0)
    80001058:	02553423          	sd	t0,40(a0)
    8000105c:	02653823          	sd	t1,48(a0)
    80001060:	02753c23          	sd	t2,56(a0)
    80001064:	04853023          	sd	s0,64(a0)
    80001068:	04953423          	sd	s1,72(a0)
    8000106c:	04a53823          	sd	a0,80(a0)
    80001070:	04b53c23          	sd	a1,88(a0)
    80001074:	06c53023          	sd	a2,96(a0)
    80001078:	06d53423          	sd	a3,104(a0)
    8000107c:	06e53823          	sd	a4,112(a0)
    80001080:	06f53c23          	sd	a5,120(a0)
    80001084:	09053023          	sd	a6,128(a0)
    80001088:	09153423          	sd	a7,136(a0)
    8000108c:	09253823          	sd	s2,144(a0)
    80001090:	09353c23          	sd	s3,152(a0)
    80001094:	0b453023          	sd	s4,160(a0)
    80001098:	0b553423          	sd	s5,168(a0)
    8000109c:	0b653823          	sd	s6,176(a0)
    800010a0:	0b753c23          	sd	s7,184(a0)
    800010a4:	0d853023          	sd	s8,192(a0)
    800010a8:	0d953423          	sd	s9,200(a0)
    800010ac:	0da53823          	sd	s10,208(a0)
    800010b0:	0db53c23          	sd	s11,216(a0)
    800010b4:	0fc53023          	sd	t3,224(a0)
    800010b8:	0fd53423          	sd	t4,232(a0)
    800010bc:	0fe53823          	sd	t5,240(a0)
    800010c0:	0ff53c23          	sd	t6,248(a0)
    800010c4:	14002373          	csrr	t1,sscratch
    800010c8:	04653823          	sd	t1,80(a0)
    800010cc:	00050113          	mv	sp,a0
    800010d0:	14002573          	csrr	a0,sscratch
    call _ZN5RISCV20handleSupervisorTrapEv
    800010d4:	0d5010ef          	jal	ra,800029a8 <_ZN5RISCV20handleSupervisorTrapEv>
    context_load
    800010d8:	0000c517          	auipc	a0,0xc
    800010dc:	c2853503          	ld	a0,-984(a0) # 8000cd00 <_ZN3TCB7runningE>
    800010e0:	00010593          	mv	a1,sp
    800010e4:	10058593          	addi	a1,a1,256
    800010e8:	00b53c23          	sd	a1,24(a0)
    800010ec:	00013003          	ld	zero,0(sp)
    800010f0:	00813083          	ld	ra,8(sp)
    800010f4:	01813183          	ld	gp,24(sp)
    800010f8:	02013203          	ld	tp,32(sp)
    800010fc:	02813283          	ld	t0,40(sp)
    80001100:	03013303          	ld	t1,48(sp)
    80001104:	03813383          	ld	t2,56(sp)
    80001108:	04013403          	ld	s0,64(sp)
    8000110c:	04813483          	ld	s1,72(sp)
    80001110:	05013503          	ld	a0,80(sp)
    80001114:	05813583          	ld	a1,88(sp)
    80001118:	06013603          	ld	a2,96(sp)
    8000111c:	06813683          	ld	a3,104(sp)
    80001120:	07013703          	ld	a4,112(sp)
    80001124:	07813783          	ld	a5,120(sp)
    80001128:	08013803          	ld	a6,128(sp)
    8000112c:	08813883          	ld	a7,136(sp)
    80001130:	09013903          	ld	s2,144(sp)
    80001134:	09813983          	ld	s3,152(sp)
    80001138:	0a013a03          	ld	s4,160(sp)
    8000113c:	0a813a83          	ld	s5,168(sp)
    80001140:	0b013b03          	ld	s6,176(sp)
    80001144:	0b813b83          	ld	s7,184(sp)
    80001148:	0c013c03          	ld	s8,192(sp)
    8000114c:	0c813c83          	ld	s9,200(sp)
    80001150:	0d013d03          	ld	s10,208(sp)
    80001154:	0d813d83          	ld	s11,216(sp)
    80001158:	0e013e03          	ld	t3,224(sp)
    8000115c:	0e813e83          	ld	t4,232(sp)
    80001160:	0f013f03          	ld	t5,240(sp)
    80001164:	0f813f83          	ld	t6,248(sp)
    80001168:	01013103          	ld	sp,16(sp)
    sret
    8000116c:	10200073          	sret

0000000080001170 <_ZN5RISCV27supervisorSoftwareInterruptEv>:
.align 4
.global _ZN5RISCV27supervisorSoftwareInterruptEv
.type _ZN5RISCV27supervisorSoftwareInterruptEv, @function
_ZN5RISCV27supervisorSoftwareInterruptEv:
    #save A0 in sscratch temporarily
    csrw sscratch, a0
    80001170:	14051073          	csrw	sscratch,a0
    #A0 = TCB::running->supervisorMode
    ld a0, _ZN3TCB7runningE
    80001174:	0000c517          	auipc	a0,0xc
    80001178:	b8c53503          	ld	a0,-1140(a0) # 8000cd00 <_ZN3TCB7runningE>
    ld a0, 40(a0)
    8000117c:	02853503          	ld	a0,40(a0)
    #supervisorMode==1, there is no need to switch stacks
    #jump to simple store_registers macro
    bne a0, zero, already_in_kernel
    80001180:	0a051863          	bnez	a0,80001230 <already_in_kernel>
    csrr a0, sscratch
    80001184:	14002573          	csrr	a0,sscratch
    context_save
    80001188:	14051073          	csrw	sscratch,a0
    8000118c:	0000c517          	auipc	a0,0xc
    80001190:	b7453503          	ld	a0,-1164(a0) # 8000cd00 <_ZN3TCB7runningE>
    80001194:	01853503          	ld	a0,24(a0)
    80001198:	f0050513          	addi	a0,a0,-256
    8000119c:	00053023          	sd	zero,0(a0)
    800011a0:	00153423          	sd	ra,8(a0)
    800011a4:	00253823          	sd	sp,16(a0)
    800011a8:	00353c23          	sd	gp,24(a0)
    800011ac:	02453023          	sd	tp,32(a0)
    800011b0:	02553423          	sd	t0,40(a0)
    800011b4:	02653823          	sd	t1,48(a0)
    800011b8:	02753c23          	sd	t2,56(a0)
    800011bc:	04853023          	sd	s0,64(a0)
    800011c0:	04953423          	sd	s1,72(a0)
    800011c4:	04a53823          	sd	a0,80(a0)
    800011c8:	04b53c23          	sd	a1,88(a0)
    800011cc:	06c53023          	sd	a2,96(a0)
    800011d0:	06d53423          	sd	a3,104(a0)
    800011d4:	06e53823          	sd	a4,112(a0)
    800011d8:	06f53c23          	sd	a5,120(a0)
    800011dc:	09053023          	sd	a6,128(a0)
    800011e0:	09153423          	sd	a7,136(a0)
    800011e4:	09253823          	sd	s2,144(a0)
    800011e8:	09353c23          	sd	s3,152(a0)
    800011ec:	0b453023          	sd	s4,160(a0)
    800011f0:	0b553423          	sd	s5,168(a0)
    800011f4:	0b653823          	sd	s6,176(a0)
    800011f8:	0b753c23          	sd	s7,184(a0)
    800011fc:	0d853023          	sd	s8,192(a0)
    80001200:	0d953423          	sd	s9,200(a0)
    80001204:	0da53823          	sd	s10,208(a0)
    80001208:	0db53c23          	sd	s11,216(a0)
    8000120c:	0fc53023          	sd	t3,224(a0)
    80001210:	0fd53423          	sd	t4,232(a0)
    80001214:	0fe53823          	sd	t5,240(a0)
    80001218:	0ff53c23          	sd	t6,248(a0)
    8000121c:	14002373          	csrr	t1,sscratch
    80001220:	04653823          	sd	t1,80(a0)
    80001224:	00050113          	mv	sp,a0
    80001228:	14002573          	csrr	a0,sscratch
    jal zero,call_trap
    8000122c:	0880006f          	j	800012b4 <call_trap>

0000000080001230 <already_in_kernel>:
    already_in_kernel:
    store_registers
    80001230:	f0010113          	addi	sp,sp,-256
    80001234:	00013023          	sd	zero,0(sp)
    80001238:	00113423          	sd	ra,8(sp)
    8000123c:	00213823          	sd	sp,16(sp)
    80001240:	00313c23          	sd	gp,24(sp)
    80001244:	02413023          	sd	tp,32(sp)
    80001248:	02513423          	sd	t0,40(sp)
    8000124c:	02613823          	sd	t1,48(sp)
    80001250:	02713c23          	sd	t2,56(sp)
    80001254:	04813023          	sd	s0,64(sp)
    80001258:	04913423          	sd	s1,72(sp)
    8000125c:	04a13823          	sd	a0,80(sp)
    80001260:	04b13c23          	sd	a1,88(sp)
    80001264:	06c13023          	sd	a2,96(sp)
    80001268:	06d13423          	sd	a3,104(sp)
    8000126c:	06e13823          	sd	a4,112(sp)
    80001270:	06f13c23          	sd	a5,120(sp)
    80001274:	09013023          	sd	a6,128(sp)
    80001278:	09113423          	sd	a7,136(sp)
    8000127c:	09213823          	sd	s2,144(sp)
    80001280:	09313c23          	sd	s3,152(sp)
    80001284:	0b413023          	sd	s4,160(sp)
    80001288:	0b513423          	sd	s5,168(sp)
    8000128c:	0b613823          	sd	s6,176(sp)
    80001290:	0b713c23          	sd	s7,184(sp)
    80001294:	0d813023          	sd	s8,192(sp)
    80001298:	0d913423          	sd	s9,200(sp)
    8000129c:	0da13823          	sd	s10,208(sp)
    800012a0:	0db13c23          	sd	s11,216(sp)
    800012a4:	0fc13023          	sd	t3,224(sp)
    800012a8:	0fd13423          	sd	t4,232(sp)
    800012ac:	0fe13823          	sd	t5,240(sp)
    800012b0:	0ff13c23          	sd	t6,248(sp)

00000000800012b4 <call_trap>:
    call_trap:

    call _ZN5RISCV33handleSupervisorSoftwareInterruptEv
    800012b4:	055010ef          	jal	ra,80002b08 <_ZN5RISCV33handleSupervisorSoftwareInterruptEv>

    #save A0 in sscratch temporarily
    csrw sscratch, a0
    800012b8:	14051073          	csrw	sscratch,a0
    #A0 = TCB::running->supervisorMode
    ld a0, _ZN3TCB7runningE
    800012bc:	0000c517          	auipc	a0,0xc
    800012c0:	a4453503          	ld	a0,-1468(a0) # 8000cd00 <_ZN3TCB7runningE>
    ld a0, 40(a0)
    800012c4:	02853503          	ld	a0,40(a0)
    #supervisorMode==1, there is no need to switch stacks
    #jump to simple load_registers macro
    bne a0, zero, already_in_kernel2
    800012c8:	0a051063          	bnez	a0,80001368 <already_in_kernel2>
    csrr a0, sscratch
    800012cc:	14002573          	csrr	a0,sscratch
    context_load
    800012d0:	0000c517          	auipc	a0,0xc
    800012d4:	a3053503          	ld	a0,-1488(a0) # 8000cd00 <_ZN3TCB7runningE>
    800012d8:	00010593          	mv	a1,sp
    800012dc:	10058593          	addi	a1,a1,256
    800012e0:	00b53c23          	sd	a1,24(a0)
    800012e4:	00013003          	ld	zero,0(sp)
    800012e8:	00813083          	ld	ra,8(sp)
    800012ec:	01813183          	ld	gp,24(sp)
    800012f0:	02013203          	ld	tp,32(sp)
    800012f4:	02813283          	ld	t0,40(sp)
    800012f8:	03013303          	ld	t1,48(sp)
    800012fc:	03813383          	ld	t2,56(sp)
    80001300:	04013403          	ld	s0,64(sp)
    80001304:	04813483          	ld	s1,72(sp)
    80001308:	05013503          	ld	a0,80(sp)
    8000130c:	05813583          	ld	a1,88(sp)
    80001310:	06013603          	ld	a2,96(sp)
    80001314:	06813683          	ld	a3,104(sp)
    80001318:	07013703          	ld	a4,112(sp)
    8000131c:	07813783          	ld	a5,120(sp)
    80001320:	08013803          	ld	a6,128(sp)
    80001324:	08813883          	ld	a7,136(sp)
    80001328:	09013903          	ld	s2,144(sp)
    8000132c:	09813983          	ld	s3,152(sp)
    80001330:	0a013a03          	ld	s4,160(sp)
    80001334:	0a813a83          	ld	s5,168(sp)
    80001338:	0b013b03          	ld	s6,176(sp)
    8000133c:	0b813b83          	ld	s7,184(sp)
    80001340:	0c013c03          	ld	s8,192(sp)
    80001344:	0c813c83          	ld	s9,200(sp)
    80001348:	0d013d03          	ld	s10,208(sp)
    8000134c:	0d813d83          	ld	s11,216(sp)
    80001350:	0e013e03          	ld	t3,224(sp)
    80001354:	0e813e83          	ld	t4,232(sp)
    80001358:	0f013f03          	ld	t5,240(sp)
    8000135c:	0f813f83          	ld	t6,248(sp)
    80001360:	01013103          	ld	sp,16(sp)
    jal zero,call_trap2
    80001364:	0880006f          	j	800013ec <call_trap2>

0000000080001368 <already_in_kernel2>:
    already_in_kernel2:
    load_registers
    80001368:	00013003          	ld	zero,0(sp)
    8000136c:	00813083          	ld	ra,8(sp)
    80001370:	01013103          	ld	sp,16(sp)
    80001374:	01813183          	ld	gp,24(sp)
    80001378:	02013203          	ld	tp,32(sp)
    8000137c:	02813283          	ld	t0,40(sp)
    80001380:	03013303          	ld	t1,48(sp)
    80001384:	03813383          	ld	t2,56(sp)
    80001388:	04013403          	ld	s0,64(sp)
    8000138c:	04813483          	ld	s1,72(sp)
    80001390:	05013503          	ld	a0,80(sp)
    80001394:	05813583          	ld	a1,88(sp)
    80001398:	06013603          	ld	a2,96(sp)
    8000139c:	06813683          	ld	a3,104(sp)
    800013a0:	07013703          	ld	a4,112(sp)
    800013a4:	07813783          	ld	a5,120(sp)
    800013a8:	08013803          	ld	a6,128(sp)
    800013ac:	08813883          	ld	a7,136(sp)
    800013b0:	09013903          	ld	s2,144(sp)
    800013b4:	09813983          	ld	s3,152(sp)
    800013b8:	0a013a03          	ld	s4,160(sp)
    800013bc:	0a813a83          	ld	s5,168(sp)
    800013c0:	0b013b03          	ld	s6,176(sp)
    800013c4:	0b813b83          	ld	s7,184(sp)
    800013c8:	0c013c03          	ld	s8,192(sp)
    800013cc:	0c813c83          	ld	s9,200(sp)
    800013d0:	0d013d03          	ld	s10,208(sp)
    800013d4:	0d813d83          	ld	s11,216(sp)
    800013d8:	0e013e03          	ld	t3,224(sp)
    800013dc:	0e813e83          	ld	t4,232(sp)
    800013e0:	0f013f03          	ld	t5,240(sp)
    800013e4:	0f813f83          	ld	t6,248(sp)
    800013e8:	10010113          	addi	sp,sp,256

00000000800013ec <call_trap2>:
    call_trap2:

    sret
    800013ec:	10200073          	sret

00000000800013f0 <_ZN5RISCV27supervisorHardwareInterruptEv>:
.extern _ZN5RISCV33handleSupervisorHardwareInterruptEv
.align 4
.global _ZN5RISCV27supervisorHardwareInterruptEv
.type _ZN5RISCV27supervisorHardwareInterruptEv, @function
_ZN5RISCV27supervisorHardwareInterruptEv:
    store_registers
    800013f0:	f0010113          	addi	sp,sp,-256
    800013f4:	00013023          	sd	zero,0(sp)
    800013f8:	00113423          	sd	ra,8(sp)
    800013fc:	00213823          	sd	sp,16(sp)
    80001400:	00313c23          	sd	gp,24(sp)
    80001404:	02413023          	sd	tp,32(sp)
    80001408:	02513423          	sd	t0,40(sp)
    8000140c:	02613823          	sd	t1,48(sp)
    80001410:	02713c23          	sd	t2,56(sp)
    80001414:	04813023          	sd	s0,64(sp)
    80001418:	04913423          	sd	s1,72(sp)
    8000141c:	04a13823          	sd	a0,80(sp)
    80001420:	04b13c23          	sd	a1,88(sp)
    80001424:	06c13023          	sd	a2,96(sp)
    80001428:	06d13423          	sd	a3,104(sp)
    8000142c:	06e13823          	sd	a4,112(sp)
    80001430:	06f13c23          	sd	a5,120(sp)
    80001434:	09013023          	sd	a6,128(sp)
    80001438:	09113423          	sd	a7,136(sp)
    8000143c:	09213823          	sd	s2,144(sp)
    80001440:	09313c23          	sd	s3,152(sp)
    80001444:	0b413023          	sd	s4,160(sp)
    80001448:	0b513423          	sd	s5,168(sp)
    8000144c:	0b613823          	sd	s6,176(sp)
    80001450:	0b713c23          	sd	s7,184(sp)
    80001454:	0d813023          	sd	s8,192(sp)
    80001458:	0d913423          	sd	s9,200(sp)
    8000145c:	0da13823          	sd	s10,208(sp)
    80001460:	0db13c23          	sd	s11,216(sp)
    80001464:	0fc13023          	sd	t3,224(sp)
    80001468:	0fd13423          	sd	t4,232(sp)
    8000146c:	0fe13823          	sd	t5,240(sp)
    80001470:	0ff13c23          	sd	t6,248(sp)
    call _ZN5RISCV33handleSupervisorHardwareInterruptEv
    80001474:	75c010ef          	jal	ra,80002bd0 <_ZN5RISCV33handleSupervisorHardwareInterruptEv>
    load_registers
    80001478:	00013003          	ld	zero,0(sp)
    8000147c:	00813083          	ld	ra,8(sp)
    80001480:	01013103          	ld	sp,16(sp)
    80001484:	01813183          	ld	gp,24(sp)
    80001488:	02013203          	ld	tp,32(sp)
    8000148c:	02813283          	ld	t0,40(sp)
    80001490:	03013303          	ld	t1,48(sp)
    80001494:	03813383          	ld	t2,56(sp)
    80001498:	04013403          	ld	s0,64(sp)
    8000149c:	04813483          	ld	s1,72(sp)
    800014a0:	05013503          	ld	a0,80(sp)
    800014a4:	05813583          	ld	a1,88(sp)
    800014a8:	06013603          	ld	a2,96(sp)
    800014ac:	06813683          	ld	a3,104(sp)
    800014b0:	07013703          	ld	a4,112(sp)
    800014b4:	07813783          	ld	a5,120(sp)
    800014b8:	08013803          	ld	a6,128(sp)
    800014bc:	08813883          	ld	a7,136(sp)
    800014c0:	09013903          	ld	s2,144(sp)
    800014c4:	09813983          	ld	s3,152(sp)
    800014c8:	0a013a03          	ld	s4,160(sp)
    800014cc:	0a813a83          	ld	s5,168(sp)
    800014d0:	0b013b03          	ld	s6,176(sp)
    800014d4:	0b813b83          	ld	s7,184(sp)
    800014d8:	0c013c03          	ld	s8,192(sp)
    800014dc:	0c813c83          	ld	s9,200(sp)
    800014e0:	0d013d03          	ld	s10,208(sp)
    800014e4:	0d813d83          	ld	s11,216(sp)
    800014e8:	0e013e03          	ld	t3,224(sp)
    800014ec:	0e813e83          	ld	t4,232(sp)
    800014f0:	0f013f03          	ld	t5,240(sp)
    800014f4:	0f813f83          	ld	t6,248(sp)
    800014f8:	10010113          	addi	sp,sp,256
    sret
    800014fc:	10200073          	sret

0000000080001500 <stvec_table>:
.global stvec_table
.align 4

stvec_table:
.org stvec_table + 0*4
jal zero,_ZN5RISCV14supervisorTrapEv
    80001500:	b31ff06f          	j	80001030 <_ZN5RISCV14supervisorTrapEv>
.org stvec_table + 1*4
jal zero,_ZN5RISCV27supervisorSoftwareInterruptEv
    80001504:	c6dff06f          	j	80001170 <_ZN5RISCV27supervisorSoftwareInterruptEv>
	...
.org stvec_table + 9*4
jal zero,_ZN5RISCV27supervisorHardwareInterruptEv
    80001524:	ecdff06f          	j	800013f0 <_ZN5RISCV27supervisorHardwareInterruptEv>

0000000080001528 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:

.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd sp, 0 * 8(a0)
    80001528:	00253023          	sd	sp,0(a0)
    sd ra, 1 * 8(sp)
    8000152c:	00113423          	sd	ra,8(sp)

    ld sp, 0 * 8(a1)
    80001530:	0005b103          	ld	sp,0(a1)
    ld ra, 1 * 8(sp)
    80001534:	00813083          	ld	ra,8(sp)
    ret
    80001538:	00008067          	ret

000000008000153c <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    8000153c:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001540:	00b29a63          	bne	t0,a1,80001554 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001544:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    80001548:	fe029ae3          	bnez	t0,8000153c <copy_and_swap>
    li a0, 0               # Set return to success.
    8000154c:	00000513          	li	a0,0
    jr ra                  # Return.
    80001550:	00008067          	ret

0000000080001554 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001554:	00100513          	li	a0,1
    80001558:	00008067          	ret

000000008000155c <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"
#include "../h/print.hpp"

void* mem_alloc(size_t size){
    8000155c:	fe010113          	addi	sp,sp,-32
    80001560:	00813c23          	sd	s0,24(sp)
    80001564:	02010413          	addi	s0,sp,32
    // Bytes to Blocks of MEM_BLOCK_SIZE
    size = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
    80001568:	03f57793          	andi	a5,a0,63
    8000156c:	02078a63          	beqz	a5,800015a0 <_Z9mem_allocm+0x44>
    80001570:	00655513          	srli	a0,a0,0x6
    80001574:	00150513          	addi	a0,a0,1
GENERATE_WRRD(ra)
GENERATE_WRRD(sp)
GENERATE_WRRD(gp)
GENERATE_WRRD(tp)
GENERATE_WRRD(a0);
GENERATE_WRRD(a1);
    80001578:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    8000157c:	00100793          	li	a5,1
    80001580:	00078513          	mv	a0,a5

    riscv_wr_a1(size);
    riscv_wr_a0(RISCV_SYS_MEM_ALLOC);

    __asm__ volatile("ecall");
    80001584:	00000073          	ecall

    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001588:	00050793          	mv	a5,a0
    8000158c:	fef43423          	sd	a5,-24(s0)
    return (void*)a0;
    80001590:	fe843503          	ld	a0,-24(s0)
}
    80001594:	01813403          	ld	s0,24(sp)
    80001598:	02010113          	addi	sp,sp,32
    8000159c:	00008067          	ret
    size = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
    800015a0:	00655513          	srli	a0,a0,0x6
    800015a4:	fd5ff06f          	j	80001578 <_Z9mem_allocm+0x1c>

00000000800015a8 <_Z8mem_freePv>:


int mem_free(void* ptr){
    800015a8:	fe010113          	addi	sp,sp,-32
    800015ac:	00813c23          	sd	s0,24(sp)
    800015b0:	02010413          	addi	s0,sp,32
GENERATE_WRRD(a1);
    800015b4:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    800015b8:	00200793          	li	a5,2
    800015bc:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)ptr);
    riscv_wr_a0(RISCV_SYS_MEM_FREE);

    __asm__ volatile("ecall");
    800015c0:	00000073          	ecall

    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800015c4:	00050793          	mv	a5,a0
    800015c8:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    800015cc:	fe843503          	ld	a0,-24(s0)

}
    800015d0:	0005051b          	sext.w	a0,a0
    800015d4:	01813403          	ld	s0,24(sp)
    800015d8:	02010113          	addi	sp,sp,32
    800015dc:	00008067          	ret

00000000800015e0 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg ){
    800015e0:	fc010113          	addi	sp,sp,-64
    800015e4:	02113c23          	sd	ra,56(sp)
    800015e8:	02813823          	sd	s0,48(sp)
    800015ec:	02913423          	sd	s1,40(sp)
    800015f0:	03213023          	sd	s2,32(sp)
    800015f4:	01313c23          	sd	s3,24(sp)
    800015f8:	01413823          	sd	s4,16(sp)
    800015fc:	04010413          	addi	s0,sp,64
    80001600:	00050993          	mv	s3,a0
    80001604:	00058913          	mv	s2,a1
    80001608:	00060a13          	mv	s4,a2

    uint64* kernel_stack_space = new uint64[TCB::KERNEL_STACK_SIZE];
    8000160c:	00002537          	lui	a0,0x2
    80001610:	00000097          	auipc	ra,0x0
    80001614:	7e0080e7          	jalr	2016(ra) # 80001df0 <_Znam>
    if(!kernel_stack_space) {
    80001618:	08050663          	beqz	a0,800016a4 <_Z13thread_createPP3TCBPFvPvES2_+0xc4>
    8000161c:	00050493          	mv	s1,a0
        return -1;
    }
    uint64* stack_space = nullptr;

    if(start_routine) stack_space = new uint64[DEFAULT_STACK_SIZE];
    80001620:	06090863          	beqz	s2,80001690 <_Z13thread_createPP3TCBPFvPvES2_+0xb0>
    80001624:	00008537          	lui	a0,0x8
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	7c8080e7          	jalr	1992(ra) # 80001df0 <_Znam>
    if(!stack_space) {
    80001630:	06050063          	beqz	a0,80001690 <_Z13thread_createPP3TCBPFvPvES2_+0xb0>
GENERATE_WRRD(a2);
GENERATE_WRRD(a3);
GENERATE_WRRD(a4);
GENERATE_WRRD(a5);
GENERATE_WRRD(a6);
GENERATE_WRRD(a7);
    80001634:	00048893          	mv	a7,s1
GENERATE_WRRD(a6);
    80001638:	00050813          	mv	a6,a0
GENERATE_WRRD(a3);
    8000163c:	000a0693          	mv	a3,s4
GENERATE_WRRD(a2);
    80001640:	00090613          	mv	a2,s2
GENERATE_WRRD(a1);
    80001644:	00098593          	mv	a1,s3
GENERATE_WRRD(a0);
    80001648:	01100793          	li	a5,17
    8000164c:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_THREAD_CREATE);



    __asm__ volatile("ecall");
    80001650:	00000073          	ecall


    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001654:	00050793          	mv	a5,a0
    80001658:	fcf43423          	sd	a5,-56(s0)

    if(a0==1){
    8000165c:	fc843703          	ld	a4,-56(s0)
    80001660:	00100793          	li	a5,1
    80001664:	04f70463          	beq	a4,a5,800016ac <_Z13thread_createPP3TCBPFvPvES2_+0xcc>
        return 0;
    }else{
        return (int)a0;
    80001668:	fc843503          	ld	a0,-56(s0)
    8000166c:	0005051b          	sext.w	a0,a0
    }


}
    80001670:	03813083          	ld	ra,56(sp)
    80001674:	03013403          	ld	s0,48(sp)
    80001678:	02813483          	ld	s1,40(sp)
    8000167c:	02013903          	ld	s2,32(sp)
    80001680:	01813983          	ld	s3,24(sp)
    80001684:	01013a03          	ld	s4,16(sp)
    80001688:	04010113          	addi	sp,sp,64
    8000168c:	00008067          	ret
        delete[] kernel_stack_space;
    80001690:	00048513          	mv	a0,s1
    80001694:	00001097          	auipc	ra,0x1
    80001698:	82c080e7          	jalr	-2004(ra) # 80001ec0 <_ZdaPv>
        return -1;
    8000169c:	fff00513          	li	a0,-1
    800016a0:	fd1ff06f          	j	80001670 <_Z13thread_createPP3TCBPFvPvES2_+0x90>
        return -1;
    800016a4:	fff00513          	li	a0,-1
    800016a8:	fc9ff06f          	j	80001670 <_Z13thread_createPP3TCBPFvPvES2_+0x90>
        return 0;
    800016ac:	00000513          	li	a0,0
    800016b0:	fc1ff06f          	j	80001670 <_Z13thread_createPP3TCBPFvPvES2_+0x90>

00000000800016b4 <_Z11thread_exitv>:

int thread_exit(){
    800016b4:	fe010113          	addi	sp,sp,-32
    800016b8:	00813c23          	sd	s0,24(sp)
    800016bc:	02010413          	addi	s0,sp,32
    800016c0:	01200793          	li	a5,18
    800016c4:	00078513          	mv	a0,a5
    riscv_wr_a0(RISCV_SYS_THREAD_EXIT);
    __asm__ volatile("ecall");
    800016c8:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800016cc:	00050793          	mv	a5,a0
    800016d0:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    800016d4:	fe843503          	ld	a0,-24(s0)
}
    800016d8:	0005051b          	sext.w	a0,a0
    800016dc:	01813403          	ld	s0,24(sp)
    800016e0:	02010113          	addi	sp,sp,32
    800016e4:	00008067          	ret

00000000800016e8 <_Z15thread_dispatchv>:
void thread_dispatch(){
    800016e8:	ff010113          	addi	sp,sp,-16
    800016ec:	00813423          	sd	s0,8(sp)
    800016f0:	01010413          	addi	s0,sp,16
    800016f4:	01300793          	li	a5,19
    800016f8:	00078513          	mv	a0,a5
    riscv_wr_a0(RISCV_SYS_THREAD_DISPATCH);
    __asm__ volatile("ecall");
    800016fc:	00000073          	ecall
}
    80001700:	00813403          	ld	s0,8(sp)
    80001704:	01010113          	addi	sp,sp,16
    80001708:	00008067          	ret

000000008000170c <_Z11thread_joinP3TCB>:
void thread_join(thread_t handle){
    8000170c:	ff010113          	addi	sp,sp,-16
    80001710:	00813423          	sd	s0,8(sp)
    80001714:	01010413          	addi	s0,sp,16
    static TCB * createThread(Body body, uint64* stack_space, uint64* kernel_stack_space, void* args=nullptr, bool putInScheduler=true);

    static void yield();

    bool isFinished() const {
        return finished;
    80001718:	03854783          	lbu	a5,56(a0) # 8038 <_entry-0x7fff7fc8>
    if(handle->isFinished()) return;
    8000171c:	00079a63          	bnez	a5,80001730 <_Z11thread_joinP3TCB+0x24>
GENERATE_WRRD(a1);
    80001720:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    80001724:	01400793          	li	a5,20
    80001728:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_THREAD_JOIN);
    __asm__ volatile("ecall");
    8000172c:	00000073          	ecall
}
    80001730:	00813403          	ld	s0,8(sp)
    80001734:	01010113          	addi	sp,sp,16
    80001738:	00008067          	ret

000000008000173c <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    8000173c:	fe010113          	addi	sp,sp,-32
    80001740:	00813c23          	sd	s0,24(sp)
    80001744:	02010413          	addi	s0,sp,32
    riscv_wr_a2((uint64)init);
    80001748:	02059593          	slli	a1,a1,0x20
    8000174c:	0205d593          	srli	a1,a1,0x20
GENERATE_WRRD(a2);
    80001750:	00058613          	mv	a2,a1
GENERATE_WRRD(a1);
    80001754:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    80001758:	02100793          	li	a5,33
    8000175c:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_SEM_OPEN);
    __asm__ volatile("ecall");
    80001760:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001764:	00050793          	mv	a5,a0
    80001768:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    8000176c:	fe843503          	ld	a0,-24(s0)
}
    80001770:	0005051b          	sext.w	a0,a0
    80001774:	01813403          	ld	s0,24(sp)
    80001778:	02010113          	addi	sp,sp,32
    8000177c:	00008067          	ret

0000000080001780 <_Z9sem_closeP4_sem>:
int sem_close(sem_t handle){
    80001780:	fe010113          	addi	sp,sp,-32
    80001784:	00813c23          	sd	s0,24(sp)
    80001788:	02010413          	addi	s0,sp,32
GENERATE_WRRD(a1);
    8000178c:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    80001790:	02200793          	li	a5,34
    80001794:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_SEM_CLOSE);
    __asm__ volatile("ecall");
    80001798:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    8000179c:	00050793          	mv	a5,a0
    800017a0:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    800017a4:	fe843503          	ld	a0,-24(s0)
}
    800017a8:	0005051b          	sext.w	a0,a0
    800017ac:	01813403          	ld	s0,24(sp)
    800017b0:	02010113          	addi	sp,sp,32
    800017b4:	00008067          	ret

00000000800017b8 <_Z8sem_waitP4_sem>:
int sem_wait(sem_t id){
    800017b8:	fe010113          	addi	sp,sp,-32
    800017bc:	00813c23          	sd	s0,24(sp)
    800017c0:	02010413          	addi	s0,sp,32
GENERATE_WRRD(a1);
    800017c4:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    800017c8:	02300793          	li	a5,35
    800017cc:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)id);
    riscv_wr_a0(RISCV_SYS_SEM_WAIT);
    __asm__ volatile("ecall");
    800017d0:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800017d4:	00050793          	mv	a5,a0
    800017d8:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    800017dc:	fe843503          	ld	a0,-24(s0)
}
    800017e0:	0005051b          	sext.w	a0,a0
    800017e4:	01813403          	ld	s0,24(sp)
    800017e8:	02010113          	addi	sp,sp,32
    800017ec:	00008067          	ret

00000000800017f0 <_Z10sem_signalP4_sem>:
int sem_signal(sem_t id){
    800017f0:	fe010113          	addi	sp,sp,-32
    800017f4:	00813c23          	sd	s0,24(sp)
    800017f8:	02010413          	addi	s0,sp,32
GENERATE_WRRD(a1);
    800017fc:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    80001800:	02400793          	li	a5,36
    80001804:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)id);
    riscv_wr_a0(RISCV_SYS_SEM_SIGNAL);
    __asm__ volatile("ecall");
    80001808:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    8000180c:	00050793          	mv	a5,a0
    80001810:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    80001814:	fe843503          	ld	a0,-24(s0)
}
    80001818:	0005051b          	sext.w	a0,a0
    8000181c:	01813403          	ld	s0,24(sp)
    80001820:	02010113          	addi	sp,sp,32
    80001824:	00008067          	ret

0000000080001828 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80001828:	fe010113          	addi	sp,sp,-32
    8000182c:	00813c23          	sd	s0,24(sp)
    80001830:	02010413          	addi	s0,sp,32
GENERATE_WRRD(a1);
    80001834:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    80001838:	03100793          	li	a5,49
    8000183c:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)time);
    riscv_wr_a0(RISCV_SYS_TIME_SLEEP);
    __asm__ volatile("ecall");
    80001840:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001844:	00050793          	mv	a5,a0
    80001848:	fef43423          	sd	a5,-24(s0)
    return (int)a0;
    8000184c:	fe843503          	ld	a0,-24(s0)
}
    80001850:	0005051b          	sext.w	a0,a0
    80001854:	01813403          	ld	s0,24(sp)
    80001858:	02010113          	addi	sp,sp,32
    8000185c:	00008067          	ret

0000000080001860 <_Z4getcv>:



char getc(){
    80001860:	fe010113          	addi	sp,sp,-32
    80001864:	00813c23          	sd	s0,24(sp)
    80001868:	02010413          	addi	s0,sp,32
    8000186c:	04100793          	li	a5,65
    80001870:	00078513          	mv	a0,a5


    riscv_wr_a0(RISCV_SYS_GETC);
    __asm__ volatile("ecall");
    80001874:	00000073          	ecall
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001878:	00050793          	mv	a5,a0
    8000187c:	fef43423          	sd	a5,-24(s0)
    return (char)a0;
    80001880:	fe843503          	ld	a0,-24(s0)
}
    80001884:	0ff57513          	andi	a0,a0,255
    80001888:	01813403          	ld	s0,24(sp)
    8000188c:	02010113          	addi	sp,sp,32
    80001890:	00008067          	ret

0000000080001894 <_Z4putcc>:
void putc (char c){
    80001894:	ff010113          	addi	sp,sp,-16
    80001898:	00813423          	sd	s0,8(sp)
    8000189c:	01010413          	addi	s0,sp,16
GENERATE_WRRD(a1);
    800018a0:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    800018a4:	04200793          	li	a5,66
    800018a8:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)c);
    riscv_wr_a0(RISCV_SYS_PUTC);
    __asm__ volatile("ecall");
    800018ac:	00000073          	ecall
}
    800018b0:	00813403          	ld	s0,8(sp)
    800018b4:	01010113          	addi	sp,sp,16
    800018b8:	00008067          	ret

00000000800018bc <_Z4pingP3TCB>:


void ping(thread_t handle){
    800018bc:	ff010113          	addi	sp,sp,-16
    800018c0:	00813423          	sd	s0,8(sp)
    800018c4:	01010413          	addi	s0,sp,16
GENERATE_WRRD(a1);
    800018c8:	00050593          	mv	a1,a0
GENERATE_WRRD(a0);
    800018cc:	00300793          	li	a5,3
    800018d0:	00078513          	mv	a0,a5
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_PING);
    __asm__ volatile("ecall");
    800018d4:	00000073          	ecall
    800018d8:	00813403          	ld	s0,8(sp)
    800018dc:	01010113          	addi	sp,sp,16
    800018e0:	00008067          	ret

00000000800018e4 <_Z41__static_initialization_and_destruction_0ii>:
        return;
    }
    idleThread =  TCB::createThread(start_routine, stack_space, kernel_stack_space, nullptr, false);


    800018e4:	ff010113          	addi	sp,sp,-16
    800018e8:	00813423          	sd	s0,8(sp)
    800018ec:	01010413          	addi	s0,sp,16
    800018f0:	00100793          	li	a5,1
    800018f4:	00f50863          	beq	a0,a5,80001904 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800018f8:	00813403          	ld	s0,8(sp)
    800018fc:	01010113          	addi	sp,sp,16
    80001900:	00008067          	ret
    80001904:	000107b7          	lui	a5,0x10
    80001908:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000190c:	fef596e3          	bne	a1,a5,800018f8 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001910:	0000b797          	auipc	a5,0xb
    80001914:	3a078793          	addi	a5,a5,928 # 8000ccb0 <_ZN9Scheduler16readyThreadQueueE>
    80001918:	0007b023          	sd	zero,0(a5)
    8000191c:	0007b423          	sd	zero,8(a5)
    80001920:	fd9ff06f          	j	800018f8 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001924 <_ZN9Scheduler3getEv>:
{
    80001924:	fe010113          	addi	sp,sp,-32
    80001928:	00113c23          	sd	ra,24(sp)
    8000192c:	00813823          	sd	s0,16(sp)
    80001930:	00913423          	sd	s1,8(sp)
    80001934:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001938:	0000b517          	auipc	a0,0xb
    8000193c:	37853503          	ld	a0,888(a0) # 8000ccb0 <_ZN9Scheduler16readyThreadQueueE>
    80001940:	04050463          	beqz	a0,80001988 <_ZN9Scheduler3getEv+0x64>

        Elem *elem = head;
        head = head->next;
    80001944:	00853783          	ld	a5,8(a0)
    80001948:	0000b717          	auipc	a4,0xb
    8000194c:	36f73423          	sd	a5,872(a4) # 8000ccb0 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001950:	02078663          	beqz	a5,8000197c <_ZN9Scheduler3getEv+0x58>

        T *ret = elem->data;
    80001954:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    80001958:	00002097          	auipc	ra,0x2
    8000195c:	030080e7          	jalr	48(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
    return temp?temp:idleThread;
    80001960:	02048463          	beqz	s1,80001988 <_ZN9Scheduler3getEv+0x64>
}
    80001964:	00048513          	mv	a0,s1
    80001968:	01813083          	ld	ra,24(sp)
    8000196c:	01013403          	ld	s0,16(sp)
    80001970:	00813483          	ld	s1,8(sp)
    80001974:	02010113          	addi	sp,sp,32
    80001978:	00008067          	ret
        if (!head) { tail = 0; }
    8000197c:	0000b797          	auipc	a5,0xb
    80001980:	3207be23          	sd	zero,828(a5) # 8000ccb8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001984:	fd1ff06f          	j	80001954 <_ZN9Scheduler3getEv+0x30>
    return temp?temp:idleThread;
    80001988:	0000b497          	auipc	s1,0xb
    8000198c:	3384b483          	ld	s1,824(s1) # 8000ccc0 <_ZN9Scheduler10idleThreadE>
    80001990:	fd5ff06f          	j	80001964 <_ZN9Scheduler3getEv+0x40>

0000000080001994 <_ZN9Scheduler3putEP3TCB>:
{
    80001994:	fe010113          	addi	sp,sp,-32
    80001998:	00113c23          	sd	ra,24(sp)
    8000199c:	00813823          	sd	s0,16(sp)
    800019a0:	00913423          	sd	s1,8(sp)
    800019a4:	02010413          	addi	s0,sp,32
    800019a8:	00050493          	mv	s1,a0
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
    800019ac:	01000513          	li	a0,16
    800019b0:	00002097          	auipc	ra,0x2
    800019b4:	f98080e7          	jalr	-104(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800019b8:	00953023          	sd	s1,0(a0)
    800019bc:	00053423          	sd	zero,8(a0)
        if (tail)
    800019c0:	0000b797          	auipc	a5,0xb
    800019c4:	2f87b783          	ld	a5,760(a5) # 8000ccb8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800019c8:	02078263          	beqz	a5,800019ec <_ZN9Scheduler3putEP3TCB+0x58>
            tail->next = elem;
    800019cc:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800019d0:	0000b797          	auipc	a5,0xb
    800019d4:	2ea7b423          	sd	a0,744(a5) # 8000ccb8 <_ZN9Scheduler16readyThreadQueueE+0x8>
}
    800019d8:	01813083          	ld	ra,24(sp)
    800019dc:	01013403          	ld	s0,16(sp)
    800019e0:	00813483          	ld	s1,8(sp)
    800019e4:	02010113          	addi	sp,sp,32
    800019e8:	00008067          	ret
            head = tail = elem;
    800019ec:	0000b797          	auipc	a5,0xb
    800019f0:	2c478793          	addi	a5,a5,708 # 8000ccb0 <_ZN9Scheduler16readyThreadQueueE>
    800019f4:	00a7b423          	sd	a0,8(a5)
    800019f8:	00a7b023          	sd	a0,0(a5)
    800019fc:	fddff06f          	j	800019d8 <_ZN9Scheduler3putEP3TCB+0x44>

0000000080001a00 <_ZN9Scheduler7setIdleEPFvPvE>:
{
    80001a00:	fe010113          	addi	sp,sp,-32
    80001a04:	00113c23          	sd	ra,24(sp)
    80001a08:	00813823          	sd	s0,16(sp)
    80001a0c:	00913423          	sd	s1,8(sp)
    80001a10:	01213023          	sd	s2,0(sp)
    80001a14:	02010413          	addi	s0,sp,32
    80001a18:	00050913          	mv	s2,a0
    uint64* kernel_stack_space = new uint64[TCB::KERNEL_STACK_SIZE];
    80001a1c:	00002537          	lui	a0,0x2
    80001a20:	00000097          	auipc	ra,0x0
    80001a24:	3d0080e7          	jalr	976(ra) # 80001df0 <_Znam>
    if(!kernel_stack_space) {
    80001a28:	04050063          	beqz	a0,80001a68 <_ZN9Scheduler7setIdleEPFvPvE+0x68>
    80001a2c:	00050493          	mv	s1,a0
    if(start_routine) stack_space = new uint64[DEFAULT_STACK_SIZE];
    80001a30:	04090863          	beqz	s2,80001a80 <_ZN9Scheduler7setIdleEPFvPvE+0x80>
    80001a34:	00008537          	lui	a0,0x8
    80001a38:	00000097          	auipc	ra,0x0
    80001a3c:	3b8080e7          	jalr	952(ra) # 80001df0 <_Znam>
    80001a40:	00050593          	mv	a1,a0
    if(!stack_space) {
    80001a44:	02050e63          	beqz	a0,80001a80 <_ZN9Scheduler7setIdleEPFvPvE+0x80>
    idleThread =  TCB::createThread(start_routine, stack_space, kernel_stack_space, nullptr, false);
    80001a48:	00000713          	li	a4,0
    80001a4c:	00000693          	li	a3,0
    80001a50:	00048613          	mv	a2,s1
    80001a54:	00090513          	mv	a0,s2
    80001a58:	00001097          	auipc	ra,0x1
    80001a5c:	310080e7          	jalr	784(ra) # 80002d68 <_ZN3TCB12createThreadEPFvPvEPmS3_S0_b>
    80001a60:	0000b797          	auipc	a5,0xb
    80001a64:	26a7b023          	sd	a0,608(a5) # 8000ccc0 <_ZN9Scheduler10idleThreadE>
    80001a68:	01813083          	ld	ra,24(sp)
    80001a6c:	01013403          	ld	s0,16(sp)
    80001a70:	00813483          	ld	s1,8(sp)
    80001a74:	00013903          	ld	s2,0(sp)
    80001a78:	02010113          	addi	sp,sp,32
    80001a7c:	00008067          	ret
        delete[] kernel_stack_space;
    80001a80:	00048513          	mv	a0,s1
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	43c080e7          	jalr	1084(ra) # 80001ec0 <_ZdaPv>
        return;
    80001a8c:	fddff06f          	j	80001a68 <_ZN9Scheduler7setIdleEPFvPvE+0x68>

0000000080001a90 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80001a90:	ff010113          	addi	sp,sp,-16
    80001a94:	00113423          	sd	ra,8(sp)
    80001a98:	00813023          	sd	s0,0(sp)
    80001a9c:	01010413          	addi	s0,sp,16
    80001aa0:	000105b7          	lui	a1,0x10
    80001aa4:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001aa8:	00100513          	li	a0,1
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	e38080e7          	jalr	-456(ra) # 800018e4 <_Z41__static_initialization_and_destruction_0ii>
    80001ab4:	00813083          	ld	ra,8(sp)
    80001ab8:	00013403          	ld	s0,0(sp)
    80001abc:	01010113          	addi	sp,sp,16
    80001ac0:	00008067          	ret

0000000080001ac4 <main>:
BoundedBuffer<char>* inputBuffer;
BoundedBuffer<char>* outputBuffer;


int main()
{
    80001ac4:	fe010113          	addi	sp,sp,-32
    80001ac8:	00113c23          	sd	ra,24(sp)
    80001acc:	00813823          	sd	s0,16(sp)
    80001ad0:	00913423          	sd	s1,8(sp)
    80001ad4:	01213023          	sd	s2,0(sp)
    80001ad8:	02010413          	addi	s0,sp,32
            return true;
        else return false;
    }

    void* operator new(size_t size){
        return MemoryAllocator::malloc_bytes(size);
    80001adc:	03000513          	li	a0,48
    80001ae0:	00002097          	auipc	ra,0x2
    80001ae4:	e68080e7          	jalr	-408(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
    80001ae8:	00050493          	mv	s1,a0

    inputBuffer = new BoundedBuffer<char>(256);
    80001aec:	10000593          	li	a1,256
    80001af0:	00000097          	auipc	ra,0x0
    80001af4:	140080e7          	jalr	320(ra) # 80001c30 <_ZN13BoundedBufferIcEC1Ei>
    80001af8:	0000b797          	auipc	a5,0xb
    80001afc:	1c97b823          	sd	s1,464(a5) # 8000ccc8 <inputBuffer>
    80001b00:	03000513          	li	a0,48
    80001b04:	00002097          	auipc	ra,0x2
    80001b08:	e44080e7          	jalr	-444(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
    80001b0c:	00050493          	mv	s1,a0
    outputBuffer = new BoundedBuffer<char>(256);
    80001b10:	10000593          	li	a1,256
    80001b14:	00000097          	auipc	ra,0x0
    80001b18:	11c080e7          	jalr	284(ra) # 80001c30 <_ZN13BoundedBufferIcEC1Ei>
    80001b1c:	03c0006f          	j	80001b58 <main+0x94>
    80001b20:	00050913          	mv	s2,a0
    }
    void operator delete (void *memory){
        MemoryAllocator::free(memory);
    80001b24:	00048513          	mv	a0,s1
    80001b28:	00002097          	auipc	ra,0x2
    80001b2c:	e60080e7          	jalr	-416(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
    80001b30:	00090513          	mv	a0,s2
    80001b34:	0000c097          	auipc	ra,0xc
    80001b38:	314080e7          	jalr	788(ra) # 8000de48 <_Unwind_Resume>
    80001b3c:	00050913          	mv	s2,a0
    80001b40:	00048513          	mv	a0,s1
    80001b44:	00002097          	auipc	ra,0x2
    80001b48:	e44080e7          	jalr	-444(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
    80001b4c:	00090513          	mv	a0,s2
    80001b50:	0000c097          	auipc	ra,0xc
    80001b54:	2f8080e7          	jalr	760(ra) # 8000de48 <_Unwind_Resume>
    80001b58:	0000b917          	auipc	s2,0xb
    80001b5c:	17090913          	addi	s2,s2,368 # 8000ccc8 <inputBuffer>
    80001b60:	00993423          	sd	s1,8(s2)
    RISCV::setSTVEC2((uint64)(&stvec_table)|1);
    80001b64:	0000b797          	auipc	a5,0xb
    80001b68:	0b47b783          	ld	a5,180(a5) # 8000cc18 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001b6c:	0017e793          	ori	a5,a5,1

};

 inline void RISCV::setSTVEC2(uint64 wtf){
    
     __asm__ volatile("csrw stvec, %[wtf]"::[wtf]"r"(wtf));
    80001b70:	10579073          	csrw	stvec,a5
        __asm__ volatile("csrw stvec, %[vector]":: [vector] "r" ((uint64)(stvec_table)|0x1));
    80001b74:	10579073          	csrw	stvec,a5
    RISCV::setSTVEC(&stvec_table);


    void* allocated = MemoryAllocator::malloc_bytes(sizeof(uint64[TCB::KERNEL_STACK_SIZE]));
    80001b78:	00002537          	lui	a0,0x2
    80001b7c:	00002097          	auipc	ra,0x2
    80001b80:	dcc080e7          	jalr	-564(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
    80001b84:	00050613          	mv	a2,a0
    uint64* kernelStack = (uint64*)allocated;

    mainThread = TCB::createThread(nullptr,nullptr,kernelStack);
    80001b88:	00100713          	li	a4,1
    80001b8c:	00000693          	li	a3,0
    80001b90:	00000593          	li	a1,0
    80001b94:	00000513          	li	a0,0
    80001b98:	00001097          	auipc	ra,0x1
    80001b9c:	1d0080e7          	jalr	464(ra) # 80002d68 <_ZN3TCB12createThreadEPFvPvEPmS3_S0_b>
    80001ba0:	00a93823          	sd	a0,16(s2)

    TCB::running = mainThread;
    80001ba4:	0000b797          	auipc	a5,0xb
    80001ba8:	09c7b783          	ld	a5,156(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    80001bac:	00a7b023          	sd	a0,0(a5)

    Scheduler::setIdle(TCB::idleThread);
    80001bb0:	0000b517          	auipc	a0,0xb
    80001bb4:	08853503          	ld	a0,136(a0) # 8000cc38 <_GLOBAL_OFFSET_TABLE_+0x48>
    80001bb8:	00000097          	auipc	ra,0x0
    80001bbc:	e48080e7          	jalr	-440(ra) # 80001a00 <_ZN9Scheduler7setIdleEPFvPvE>
GENERATE_CSR(sstatus);
    80001bc0:	00200793          	li	a5,2
    80001bc4:	1007a073          	csrs	sstatus,a5
    

    RISCV::enableExternalInterrupts();
    RISCV::switchToUserLevelMode();
    80001bc8:	00001097          	auipc	ra,0x1
    80001bcc:	d88080e7          	jalr	-632(ra) # 80002950 <_ZN5RISCV21switchToUserLevelModeEv>

    thread_create(&consoleThread, TCB::consoleWriteThread,nullptr);
    80001bd0:	00000613          	li	a2,0
    80001bd4:	0000b597          	auipc	a1,0xb
    80001bd8:	07c5b583          	ld	a1,124(a1) # 8000cc50 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001bdc:	0000b517          	auipc	a0,0xb
    80001be0:	10450513          	addi	a0,a0,260 # 8000cce0 <consoleThread>
    80001be4:	00000097          	auipc	ra,0x0
    80001be8:	9fc080e7          	jalr	-1540(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>


    thread_create(&userMainThread,userMain, nullptr );
    80001bec:	00000613          	li	a2,0
    80001bf0:	0000b597          	auipc	a1,0xb
    80001bf4:	0405b583          	ld	a1,64(a1) # 8000cc30 <_GLOBAL_OFFSET_TABLE_+0x40>
    80001bf8:	0000b517          	auipc	a0,0xb
    80001bfc:	0f050513          	addi	a0,a0,240 # 8000cce8 <userMainThread>
    80001c00:	00000097          	auipc	ra,0x0
    80001c04:	9e0080e7          	jalr	-1568(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    thread_join(userMainThread);
    80001c08:	02093503          	ld	a0,32(s2)
    80001c0c:	00000097          	auipc	ra,0x0
    80001c10:	b00080e7          	jalr	-1280(ra) # 8000170c <_Z11thread_joinP3TCB>
    //thread_join(consoleThread);
    return 0;
    80001c14:	00000513          	li	a0,0
    80001c18:	01813083          	ld	ra,24(sp)
    80001c1c:	01013403          	ld	s0,16(sp)
    80001c20:	00813483          	ld	s1,8(sp)
    80001c24:	00013903          	ld	s2,0(sp)
    80001c28:	02010113          	addi	sp,sp,32
    80001c2c:	00008067          	ret

0000000080001c30 <_ZN13BoundedBufferIcEC1Ei>:
    BoundedBuffer(int size=256){
    80001c30:	fe010113          	addi	sp,sp,-32
    80001c34:	00113c23          	sd	ra,24(sp)
    80001c38:	00813823          	sd	s0,16(sp)
    80001c3c:	00913423          	sd	s1,8(sp)
    80001c40:	01213023          	sd	s2,0(sp)
    80001c44:	02010413          	addi	s0,sp,32
    80001c48:	00050493          	mv	s1,a0
    80001c4c:	00058913          	mv	s2,a1
        this-> mutex = new _sem(1);
    80001c50:	02000513          	li	a0,32
    80001c54:	00002097          	auipc	ra,0x2
    80001c58:	980080e7          	jalr	-1664(ra) # 800035d4 <_ZN4_semnwEm>
#include "RISCV.hpp"
#include "TCB.hpp"

class _sem {
    public:
        _sem(unsigned short init = 1) : val(init){}
    80001c5c:	00100793          	li	a5,1
    80001c60:	00f52023          	sw	a5,0(a0)
    80001c64:	00053423          	sd	zero,8(a0)
    List() : head(0), tail(0) {}
    80001c68:	00053823          	sd	zero,16(a0)
    80001c6c:	00053c23          	sd	zero,24(a0)
    80001c70:	00a4bc23          	sd	a0,24(s1)
        this-> notEmpty = new _sem(0);
    80001c74:	02000513          	li	a0,32
    80001c78:	00002097          	auipc	ra,0x2
    80001c7c:	95c080e7          	jalr	-1700(ra) # 800035d4 <_ZN4_semnwEm>
    80001c80:	00052023          	sw	zero,0(a0)
    80001c84:	00053423          	sd	zero,8(a0)
    80001c88:	00053823          	sd	zero,16(a0)
    80001c8c:	00053c23          	sd	zero,24(a0)
    80001c90:	02a4b023          	sd	a0,32(s1)
        this-> notFull = new _sem(0);
    80001c94:	02000513          	li	a0,32
    80001c98:	00002097          	auipc	ra,0x2
    80001c9c:	93c080e7          	jalr	-1732(ra) # 800035d4 <_ZN4_semnwEm>
    80001ca0:	00052023          	sw	zero,0(a0)
    80001ca4:	00053423          	sd	zero,8(a0)
    80001ca8:	00053823          	sd	zero,16(a0)
    80001cac:	00053c23          	sd	zero,24(a0)
    80001cb0:	02a4b423          	sd	a0,40(s1)
        this-> size = size;
    80001cb4:	0124a423          	sw	s2,8(s1)
        this->front=this->rear = -1;
    80001cb8:	fff00793          	li	a5,-1
    80001cbc:	00f4a623          	sw	a5,12(s1)
    80001cc0:	00f4a823          	sw	a5,16(s1)
        this->buffer = (T*) MemoryAllocator::malloc_bytes(size*sizeof(T));
    80001cc4:	00090513          	mv	a0,s2
    80001cc8:	00002097          	auipc	ra,0x2
    80001ccc:	c80080e7          	jalr	-896(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
    80001cd0:	00a4b023          	sd	a0,0(s1)
    }
    80001cd4:	01813083          	ld	ra,24(sp)
    80001cd8:	01013403          	ld	s0,16(sp)
    80001cdc:	00813483          	ld	s1,8(sp)
    80001ce0:	00013903          	ld	s2,0(sp)
    80001ce4:	02010113          	addi	sp,sp,32
    80001ce8:	00008067          	ret

0000000080001cec <_ZN6Thread7wrapperEPv>:
    this->arg = this;
    this->myHandle = nullptr;
}

void Thread::wrapper(void* ptr) {
    if(ptr) ((Thread*)ptr)->run();
    80001cec:	02050863          	beqz	a0,80001d1c <_ZN6Thread7wrapperEPv+0x30>
void Thread::wrapper(void* ptr) {
    80001cf0:	ff010113          	addi	sp,sp,-16
    80001cf4:	00113423          	sd	ra,8(sp)
    80001cf8:	00813023          	sd	s0,0(sp)
    80001cfc:	01010413          	addi	s0,sp,16
    if(ptr) ((Thread*)ptr)->run();
    80001d00:	00053783          	ld	a5,0(a0)
    80001d04:	0107b783          	ld	a5,16(a5)
    80001d08:	000780e7          	jalr	a5
}
    80001d0c:	00813083          	ld	ra,8(sp)
    80001d10:	00013403          	ld	s0,0(sp)
    80001d14:	01010113          	addi	sp,sp,16
    80001d18:	00008067          	ret
    80001d1c:	00008067          	ret

0000000080001d20 <_ZN6ThreadD1Ev>:
Thread::~Thread() {
    80001d20:	fe010113          	addi	sp,sp,-32
    80001d24:	00113c23          	sd	ra,24(sp)
    80001d28:	00813823          	sd	s0,16(sp)
    80001d2c:	00913423          	sd	s1,8(sp)
    80001d30:	02010413          	addi	s0,sp,32
    80001d34:	0000b797          	auipc	a5,0xb
    80001d38:	ac478793          	addi	a5,a5,-1340 # 8000c7f8 <_ZTV6Thread+0x10>
    80001d3c:	00f53023          	sd	a5,0(a0)
    delete this->myHandle;
    80001d40:	00853483          	ld	s1,8(a0)
    80001d44:	00048e63          	beqz	s1,80001d60 <_ZN6ThreadD1Ev+0x40>
    80001d48:	00048513          	mv	a0,s1
    80001d4c:	00001097          	auipc	ra,0x1
    80001d50:	fd0080e7          	jalr	-48(ra) # 80002d1c <_ZN3TCBD1Ev>
    80001d54:	00048513          	mv	a0,s1
    80001d58:	00001097          	auipc	ra,0x1
    80001d5c:	efc080e7          	jalr	-260(ra) # 80002c54 <_ZN3TCBdlEPv>
}
    80001d60:	01813083          	ld	ra,24(sp)
    80001d64:	01013403          	ld	s0,16(sp)
    80001d68:	00813483          	ld	s1,8(sp)
    80001d6c:	02010113          	addi	sp,sp,32
    80001d70:	00008067          	ret

0000000080001d74 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    myHandle = new _sem(init);
}

Semaphore::~Semaphore() {
    80001d74:	fe010113          	addi	sp,sp,-32
    80001d78:	00113c23          	sd	ra,24(sp)
    80001d7c:	00813823          	sd	s0,16(sp)
    80001d80:	00913423          	sd	s1,8(sp)
    80001d84:	02010413          	addi	s0,sp,32
    80001d88:	0000b797          	auipc	a5,0xb
    80001d8c:	a9878793          	addi	a5,a5,-1384 # 8000c820 <_ZTV9Semaphore+0x10>
    80001d90:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80001d94:	00853483          	ld	s1,8(a0)
    80001d98:	00048e63          	beqz	s1,80001db4 <_ZN9SemaphoreD1Ev+0x40>
    80001d9c:	00048513          	mv	a0,s1
    80001da0:	00002097          	auipc	ra,0x2
    80001da4:	8a0080e7          	jalr	-1888(ra) # 80003640 <_ZN4_semD1Ev>
    80001da8:	00048513          	mv	a0,s1
    80001dac:	00002097          	auipc	ra,0x2
    80001db0:	86c080e7          	jalr	-1940(ra) # 80003618 <_ZN4_semdlEPv>
}
    80001db4:	01813083          	ld	ra,24(sp)
    80001db8:	01013403          	ld	s0,16(sp)
    80001dbc:	00813483          	ld	s1,8(sp)
    80001dc0:	02010113          	addi	sp,sp,32
    80001dc4:	00008067          	ret

0000000080001dc8 <_Znwm>:
{
    80001dc8:	ff010113          	addi	sp,sp,-16
    80001dcc:	00113423          	sd	ra,8(sp)
    80001dd0:	00813023          	sd	s0,0(sp)
    80001dd4:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001dd8:	fffff097          	auipc	ra,0xfffff
    80001ddc:	784080e7          	jalr	1924(ra) # 8000155c <_Z9mem_allocm>
}
    80001de0:	00813083          	ld	ra,8(sp)
    80001de4:	00013403          	ld	s0,0(sp)
    80001de8:	01010113          	addi	sp,sp,16
    80001dec:	00008067          	ret

0000000080001df0 <_Znam>:
{
    80001df0:	ff010113          	addi	sp,sp,-16
    80001df4:	00113423          	sd	ra,8(sp)
    80001df8:	00813023          	sd	s0,0(sp)
    80001dfc:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001e00:	fffff097          	auipc	ra,0xfffff
    80001e04:	75c080e7          	jalr	1884(ra) # 8000155c <_Z9mem_allocm>
}
    80001e08:	00813083          	ld	ra,8(sp)
    80001e0c:	00013403          	ld	s0,0(sp)
    80001e10:	01010113          	addi	sp,sp,16
    80001e14:	00008067          	ret

0000000080001e18 <_ZdlPv>:
{
    80001e18:	ff010113          	addi	sp,sp,-16
    80001e1c:	00113423          	sd	ra,8(sp)
    80001e20:	00813023          	sd	s0,0(sp)
    80001e24:	01010413          	addi	s0,sp,16
    mem_free(p);
    80001e28:	fffff097          	auipc	ra,0xfffff
    80001e2c:	780080e7          	jalr	1920(ra) # 800015a8 <_Z8mem_freePv>
}
    80001e30:	00813083          	ld	ra,8(sp)
    80001e34:	00013403          	ld	s0,0(sp)
    80001e38:	01010113          	addi	sp,sp,16
    80001e3c:	00008067          	ret

0000000080001e40 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001e40:	fe010113          	addi	sp,sp,-32
    80001e44:	00113c23          	sd	ra,24(sp)
    80001e48:	00813823          	sd	s0,16(sp)
    80001e4c:	00913423          	sd	s1,8(sp)
    80001e50:	02010413          	addi	s0,sp,32
    80001e54:	00050493          	mv	s1,a0
}
    80001e58:	00000097          	auipc	ra,0x0
    80001e5c:	ec8080e7          	jalr	-312(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80001e60:	00048513          	mv	a0,s1
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	fb4080e7          	jalr	-76(ra) # 80001e18 <_ZdlPv>
    80001e6c:	01813083          	ld	ra,24(sp)
    80001e70:	01013403          	ld	s0,16(sp)
    80001e74:	00813483          	ld	s1,8(sp)
    80001e78:	02010113          	addi	sp,sp,32
    80001e7c:	00008067          	ret

0000000080001e80 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001e80:	fe010113          	addi	sp,sp,-32
    80001e84:	00113c23          	sd	ra,24(sp)
    80001e88:	00813823          	sd	s0,16(sp)
    80001e8c:	00913423          	sd	s1,8(sp)
    80001e90:	02010413          	addi	s0,sp,32
    80001e94:	00050493          	mv	s1,a0
}
    80001e98:	00000097          	auipc	ra,0x0
    80001e9c:	edc080e7          	jalr	-292(ra) # 80001d74 <_ZN9SemaphoreD1Ev>
    80001ea0:	00048513          	mv	a0,s1
    80001ea4:	00000097          	auipc	ra,0x0
    80001ea8:	f74080e7          	jalr	-140(ra) # 80001e18 <_ZdlPv>
    80001eac:	01813083          	ld	ra,24(sp)
    80001eb0:	01013403          	ld	s0,16(sp)
    80001eb4:	00813483          	ld	s1,8(sp)
    80001eb8:	02010113          	addi	sp,sp,32
    80001ebc:	00008067          	ret

0000000080001ec0 <_ZdaPv>:
{
    80001ec0:	ff010113          	addi	sp,sp,-16
    80001ec4:	00113423          	sd	ra,8(sp)
    80001ec8:	00813023          	sd	s0,0(sp)
    80001ecc:	01010413          	addi	s0,sp,16
    mem_free(p);
    80001ed0:	fffff097          	auipc	ra,0xfffff
    80001ed4:	6d8080e7          	jalr	1752(ra) # 800015a8 <_Z8mem_freePv>
}
    80001ed8:	00813083          	ld	ra,8(sp)
    80001edc:	00013403          	ld	s0,0(sp)
    80001ee0:	01010113          	addi	sp,sp,16
    80001ee4:	00008067          	ret

0000000080001ee8 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001ee8:	ff010113          	addi	sp,sp,-16
    80001eec:	00813423          	sd	s0,8(sp)
    80001ef0:	01010413          	addi	s0,sp,16
    80001ef4:	0000b797          	auipc	a5,0xb
    80001ef8:	90478793          	addi	a5,a5,-1788 # 8000c7f8 <_ZTV6Thread+0x10>
    80001efc:	00f53023          	sd	a5,0(a0)
    this->body = body;
    80001f00:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    80001f04:	00c53c23          	sd	a2,24(a0)
    this->myHandle = nullptr;
    80001f08:	00053423          	sd	zero,8(a0)
}
    80001f0c:	00813403          	ld	s0,8(sp)
    80001f10:	01010113          	addi	sp,sp,16
    80001f14:	00008067          	ret

0000000080001f18 <_ZN6Thread5startEv>:
int Thread::start() {
    80001f18:	ff010113          	addi	sp,sp,-16
    80001f1c:	00113423          	sd	ra,8(sp)
    80001f20:	00813023          	sd	s0,0(sp)
    80001f24:	01010413          	addi	s0,sp,16
    return thread_create(&this->myHandle, body, arg);
    80001f28:	01853603          	ld	a2,24(a0)
    80001f2c:	01053583          	ld	a1,16(a0)
    80001f30:	00850513          	addi	a0,a0,8
    80001f34:	fffff097          	auipc	ra,0xfffff
    80001f38:	6ac080e7          	jalr	1708(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
}
    80001f3c:	00813083          	ld	ra,8(sp)
    80001f40:	00013403          	ld	s0,0(sp)
    80001f44:	01010113          	addi	sp,sp,16
    80001f48:	00008067          	ret

0000000080001f4c <_ZN6Thread4joinEv>:
void Thread::join() {
    80001f4c:	ff010113          	addi	sp,sp,-16
    80001f50:	00113423          	sd	ra,8(sp)
    80001f54:	00813023          	sd	s0,0(sp)
    80001f58:	01010413          	addi	s0,sp,16
    thread_join(this->myHandle);
    80001f5c:	00853503          	ld	a0,8(a0)
    80001f60:	fffff097          	auipc	ra,0xfffff
    80001f64:	7ac080e7          	jalr	1964(ra) # 8000170c <_Z11thread_joinP3TCB>
}
    80001f68:	00813083          	ld	ra,8(sp)
    80001f6c:	00013403          	ld	s0,0(sp)
    80001f70:	01010113          	addi	sp,sp,16
    80001f74:	00008067          	ret

0000000080001f78 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001f78:	ff010113          	addi	sp,sp,-16
    80001f7c:	00113423          	sd	ra,8(sp)
    80001f80:	00813023          	sd	s0,0(sp)
    80001f84:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001f88:	fffff097          	auipc	ra,0xfffff
    80001f8c:	760080e7          	jalr	1888(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80001f90:	00813083          	ld	ra,8(sp)
    80001f94:	00013403          	ld	s0,0(sp)
    80001f98:	01010113          	addi	sp,sp,16
    80001f9c:	00008067          	ret

0000000080001fa0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80001fa0:	ff010113          	addi	sp,sp,-16
    80001fa4:	00113423          	sd	ra,8(sp)
    80001fa8:	00813023          	sd	s0,0(sp)
    80001fac:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80001fb0:	00000097          	auipc	ra,0x0
    80001fb4:	878080e7          	jalr	-1928(ra) # 80001828 <_Z10time_sleepm>
}
    80001fb8:	00813083          	ld	ra,8(sp)
    80001fbc:	00013403          	ld	s0,0(sp)
    80001fc0:	01010113          	addi	sp,sp,16
    80001fc4:	00008067          	ret

0000000080001fc8 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001fc8:	ff010113          	addi	sp,sp,-16
    80001fcc:	00813423          	sd	s0,8(sp)
    80001fd0:	01010413          	addi	s0,sp,16
    80001fd4:	0000b797          	auipc	a5,0xb
    80001fd8:	82478793          	addi	a5,a5,-2012 # 8000c7f8 <_ZTV6Thread+0x10>
    80001fdc:	00f53023          	sd	a5,0(a0)
    this->body = Thread::wrapper; //&wrapper ?
    80001fe0:	00000797          	auipc	a5,0x0
    80001fe4:	d0c78793          	addi	a5,a5,-756 # 80001cec <_ZN6Thread7wrapperEPv>
    80001fe8:	00f53823          	sd	a5,16(a0)
    this->arg = this;
    80001fec:	00a53c23          	sd	a0,24(a0)
    this->myHandle = nullptr;
    80001ff0:	00053423          	sd	zero,8(a0)
}
    80001ff4:	00813403          	ld	s0,8(sp)
    80001ff8:	01010113          	addi	sp,sp,16
    80001ffc:	00008067          	ret

0000000080002000 <_ZN7Console4getcEv>:
char Console::getc() {
    80002000:	ff010113          	addi	sp,sp,-16
    80002004:	00113423          	sd	ra,8(sp)
    80002008:	00813023          	sd	s0,0(sp)
    8000200c:	01010413          	addi	s0,sp,16
    return ::getc();
    80002010:	00000097          	auipc	ra,0x0
    80002014:	850080e7          	jalr	-1968(ra) # 80001860 <_Z4getcv>
}
    80002018:	00813083          	ld	ra,8(sp)
    8000201c:	00013403          	ld	s0,0(sp)
    80002020:	01010113          	addi	sp,sp,16
    80002024:	00008067          	ret

0000000080002028 <_ZN7Console4putcEc>:
void Console::putc(char c) {
    80002028:	ff010113          	addi	sp,sp,-16
    8000202c:	00113423          	sd	ra,8(sp)
    80002030:	00813023          	sd	s0,0(sp)
    80002034:	01010413          	addi	s0,sp,16
    ::putc(c);
    80002038:	00000097          	auipc	ra,0x0
    8000203c:	85c080e7          	jalr	-1956(ra) # 80001894 <_Z4putcc>
}
    80002040:	00813083          	ld	ra,8(sp)
    80002044:	00013403          	ld	s0,0(sp)
    80002048:	01010113          	addi	sp,sp,16
    8000204c:	00008067          	ret

0000000080002050 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80002050:	ff010113          	addi	sp,sp,-16
    80002054:	00113423          	sd	ra,8(sp)
    80002058:	00813023          	sd	s0,0(sp)
    8000205c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002060:	00853503          	ld	a0,8(a0)
    80002064:	fffff097          	auipc	ra,0xfffff
    80002068:	754080e7          	jalr	1876(ra) # 800017b8 <_Z8sem_waitP4_sem>
}
    8000206c:	00813083          	ld	ra,8(sp)
    80002070:	00013403          	ld	s0,0(sp)
    80002074:	01010113          	addi	sp,sp,16
    80002078:	00008067          	ret

000000008000207c <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    8000207c:	ff010113          	addi	sp,sp,-16
    80002080:	00113423          	sd	ra,8(sp)
    80002084:	00813023          	sd	s0,0(sp)
    80002088:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    8000208c:	00853503          	ld	a0,8(a0)
    80002090:	fffff097          	auipc	ra,0xfffff
    80002094:	760080e7          	jalr	1888(ra) # 800017f0 <_Z10sem_signalP4_sem>
}
    80002098:	00813083          	ld	ra,8(sp)
    8000209c:	00013403          	ld	s0,0(sp)
    800020a0:	01010113          	addi	sp,sp,16
    800020a4:	00008067          	ret

00000000800020a8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800020a8:	fe010113          	addi	sp,sp,-32
    800020ac:	00113c23          	sd	ra,24(sp)
    800020b0:	00813823          	sd	s0,16(sp)
    800020b4:	00913423          	sd	s1,8(sp)
    800020b8:	01213023          	sd	s2,0(sp)
    800020bc:	02010413          	addi	s0,sp,32
    800020c0:	00050913          	mv	s2,a0
    800020c4:	00058493          	mv	s1,a1
    800020c8:	0000a797          	auipc	a5,0xa
    800020cc:	75878793          	addi	a5,a5,1880 # 8000c820 <_ZTV9Semaphore+0x10>
    800020d0:	00f53023          	sd	a5,0(a0)
    myHandle = new _sem(init);
    800020d4:	02000513          	li	a0,32
    800020d8:	00001097          	auipc	ra,0x1
    800020dc:	4fc080e7          	jalr	1276(ra) # 800035d4 <_ZN4_semnwEm>
#include "RISCV.hpp"
#include "TCB.hpp"

class _sem {
    public:
        _sem(unsigned short init = 1) : val(init){}
    800020e0:	03049493          	slli	s1,s1,0x30
    800020e4:	0304d493          	srli	s1,s1,0x30
    800020e8:	00952023          	sw	s1,0(a0)
    800020ec:	00053423          	sd	zero,8(a0)
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    800020f0:	00053823          	sd	zero,16(a0)
    800020f4:	00053c23          	sd	zero,24(a0)
    800020f8:	00a93423          	sd	a0,8(s2)
}
    800020fc:	01813083          	ld	ra,24(sp)
    80002100:	01013403          	ld	s0,16(sp)
    80002104:	00813483          	ld	s1,8(sp)
    80002108:	00013903          	ld	s2,0(sp)
    8000210c:	02010113          	addi	sp,sp,32
    80002110:	00008067          	ret

0000000080002114 <_ZN6Thread3runEv>:
    void join();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread();
    virtual void run() {};
    80002114:	ff010113          	addi	sp,sp,-16
    80002118:	00813423          	sd	s0,8(sp)
    8000211c:	01010413          	addi	s0,sp,16
    80002120:	00813403          	ld	s0,8(sp)
    80002124:	01010113          	addi	sp,sp,16
    80002128:	00008067          	ret

000000008000212c <_ZN5RISCV13sys_call_pingEv>:
    riscv_csrw_sepc(sepc);
    TCB::switchSupervisorMode();

}

void RISCV::sys_call_ping(){
    8000212c:	fc010113          	addi	sp,sp,-64
    80002130:	02813c23          	sd	s0,56(sp)
    80002134:	04010413          	addi	s0,sp,64
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    80002138:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    8000213c:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002140:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    80002144:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002148:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000214c:	141027f3          	csrr	a5,sepc
    80002150:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80002154:	fd843783          	ld	a5,-40(s0)
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    80002158:	00478793          	addi	a5,a5,4
    8000215c:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002160:	100027f3          	csrr	a5,sstatus
    80002164:	fcf43823          	sd	a5,-48(s0)
    80002168:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    8000216c:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a1);
    80002170:	00058793          	mv	a5,a1
    80002174:	fcf43423          	sd	a5,-56(s0)
    80002178:	fc843783          	ld	a5,-56(s0)
    inline void decreseSleepTime(){
        sleepTime--;
    }

    void setPingedPending(){
        pending_ping = true;
    8000217c:	00100713          	li	a4,1
    80002180:	04e78ca3          	sb	a4,89(a5)

    thread_t handle = (thread_t)riscv_rd_a1();
    handle->setPingedPending();

    riscv_csrw_sstatus(sstatus);
    80002184:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    80002188:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    8000218c:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    80002190:	14179073          	csrw	sepc,a5
}
    80002194:	03813403          	ld	s0,56(sp)
    80002198:	04010113          	addi	sp,sp,64
    8000219c:	00008067          	ret

00000000800021a0 <_ZN5RISCV18sys_call_mem_allocEv>:
void RISCV::sys_call_mem_alloc(){
    800021a0:	fd010113          	addi	sp,sp,-48
    800021a4:	02113423          	sd	ra,40(sp)
    800021a8:	02813023          	sd	s0,32(sp)
    800021ac:	03010413          	addi	s0,sp,48
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800021b0:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800021b4:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800021b8:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800021bc:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    800021c0:	02043783          	ld	a5,32(s0)
GENERATE_WRRD(a1);
    800021c4:	00058793          	mv	a5,a1
    800021c8:	fcf43c23          	sd	a5,-40(s0)
    800021cc:	fd843783          	ld	a5,-40(s0)
    uint64 volatile a1 = riscv_rd_a1();
    800021d0:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sepc);
    800021d4:	141027f3          	csrr	a5,sepc
    800021d8:	fcf43823          	sd	a5,-48(s0)
    800021dc:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sepc = riscv_csrr_sepc();
    800021e0:	fef43023          	sd	a5,-32(s0)
    void* ptr = MemoryAllocator::malloc((size_t)a1);
    800021e4:	fe843503          	ld	a0,-24(s0)
    800021e8:	00001097          	auipc	ra,0x1
    800021ec:	6b0080e7          	jalr	1712(ra) # 80003898 <_ZN15MemoryAllocator6mallocEm>
GENERATE_WRRD(a0);
    800021f0:	00050513          	mv	a0,a0
    riscv_csrw_sepc(sepc + 4);
    800021f4:	fe043783          	ld	a5,-32(s0)
    800021f8:	00478793          	addi	a5,a5,4
GENERATE_CSR(sepc);
    800021fc:	14179073          	csrw	sepc,a5
};
    80002200:	02813083          	ld	ra,40(sp)
    80002204:	02013403          	ld	s0,32(sp)
    80002208:	03010113          	addi	sp,sp,48
    8000220c:	00008067          	ret

0000000080002210 <_ZN5RISCV17sys_call_mem_freeEv>:
void RISCV::sys_call_mem_free(){
    80002210:	fd010113          	addi	sp,sp,-48
    80002214:	02113423          	sd	ra,40(sp)
    80002218:	02813023          	sd	s0,32(sp)
    8000221c:	03010413          	addi	s0,sp,48
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    80002220:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    80002224:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002228:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    8000222c:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002230:	02043783          	ld	a5,32(s0)
GENERATE_WRRD(a1);
    80002234:	00058793          	mv	a5,a1
    80002238:	fcf43c23          	sd	a5,-40(s0)
    8000223c:	fd843783          	ld	a5,-40(s0)
    uint64 volatile a1 = riscv_rd_a1();
    80002240:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sepc);
    80002244:	141027f3          	csrr	a5,sepc
    80002248:	fcf43823          	sd	a5,-48(s0)
    8000224c:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sepc = riscv_csrr_sepc();
    80002250:	fef43023          	sd	a5,-32(s0)
    uint64 return_value = (uint64) MemoryAllocator::free((void*)a1);
    80002254:	fe843503          	ld	a0,-24(s0)
    80002258:	00001097          	auipc	ra,0x1
    8000225c:	730080e7          	jalr	1840(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
GENERATE_WRRD(a0);
    80002260:	00050513          	mv	a0,a0
    riscv_csrw_sepc(sepc + 4);
    80002264:	fe043783          	ld	a5,-32(s0)
    80002268:	00478793          	addi	a5,a5,4
GENERATE_CSR(sepc);
    8000226c:	14179073          	csrw	sepc,a5
};
    80002270:	02813083          	ld	ra,40(sp)
    80002274:	02013403          	ld	s0,32(sp)
    80002278:	03010113          	addi	sp,sp,48
    8000227c:	00008067          	ret

0000000080002280 <_ZN5RISCV22sys_call_thread_createEv>:
void RISCV::sys_call_thread_create(){
    80002280:	f9010113          	addi	sp,sp,-112
    80002284:	06113423          	sd	ra,104(sp)
    80002288:	06813023          	sd	s0,96(sp)
    8000228c:	07010413          	addi	s0,sp,112
    80002290:	141027f3          	csrr	a5,sepc
    80002294:	faf43c23          	sd	a5,-72(s0)
    80002298:	fb843783          	ld	a5,-72(s0)
    uint64 volatile sepc = riscv_csrr_sepc();
    8000229c:	fef43423          	sd	a5,-24(s0)
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800022a0:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800022a4:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800022a8:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800022ac:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    800022b0:	02043783          	ld	a5,32(s0)
GENERATE_WRRD(a1);
    800022b4:	00058793          	mv	a5,a1
    800022b8:	faf43823          	sd	a5,-80(s0)
    800022bc:	fb043783          	ld	a5,-80(s0)
    thread_t* volatile handle = (thread_t*)riscv_rd_a1();
    800022c0:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a2);
    800022c4:	00060793          	mv	a5,a2
    800022c8:	faf43423          	sd	a5,-88(s0)
    800022cc:	fa843783          	ld	a5,-88(s0)
    TCB::Body volatile body = (TCB::Body) riscv_rd_a2();
    800022d0:	fcf43c23          	sd	a5,-40(s0)
GENERATE_WRRD(a3);
    800022d4:	00068793          	mv	a5,a3
    800022d8:	faf43023          	sd	a5,-96(s0)
    800022dc:	fa043783          	ld	a5,-96(s0)
    void* volatile args = (void*) riscv_rd_a3();
    800022e0:	fcf43823          	sd	a5,-48(s0)
GENERATE_WRRD(a6);
    800022e4:	00080793          	mv	a5,a6
    800022e8:	f8f43c23          	sd	a5,-104(s0)
    800022ec:	f9843783          	ld	a5,-104(s0)
    uint64* volatile stack_space = ( uint64*) riscv_rd_a6();;
    800022f0:	fcf43423          	sd	a5,-56(s0)
GENERATE_WRRD(a7);
    800022f4:	00088793          	mv	a5,a7
    800022f8:	f8f43823          	sd	a5,-112(s0)
    800022fc:	f9043783          	ld	a5,-112(s0)
    uint64* volatile kernel_stack_space =( uint64*) riscv_rd_a7();;
    80002300:	fcf43023          	sd	a5,-64(s0)
    TCB* tcb = TCB::createThread(body, stack_space, kernel_stack_space, args);
    80002304:	fd843503          	ld	a0,-40(s0)
    80002308:	fc843583          	ld	a1,-56(s0)
    8000230c:	fc043603          	ld	a2,-64(s0)
    80002310:	fd043683          	ld	a3,-48(s0)
    80002314:	00100713          	li	a4,1
    80002318:	00001097          	auipc	ra,0x1
    8000231c:	a50080e7          	jalr	-1456(ra) # 80002d68 <_ZN3TCB12createThreadEPFvPvEPmS3_S0_b>
    if(tcb != nullptr){
    80002320:	02050863          	beqz	a0,80002350 <_ZN5RISCV22sys_call_thread_createEv+0xd0>
        __asm__ volatile ("sd %[src], (%[dest])" :: [src] "r" (tcb), [dest] "r" (handle));
    80002324:	fe043783          	ld	a5,-32(s0)
    80002328:	00a7b023          	sd	a0,0(a5)
GENERATE_WRRD(a0);
    8000232c:	00100793          	li	a5,1
    80002330:	00078513          	mv	a0,a5
    riscv_csrw_sepc(sepc + 4);
    80002334:	fe843783          	ld	a5,-24(s0)
    80002338:	00478793          	addi	a5,a5,4
GENERATE_CSR(sepc);
    8000233c:	14179073          	csrw	sepc,a5
};
    80002340:	06813083          	ld	ra,104(sp)
    80002344:	06013403          	ld	s0,96(sp)
    80002348:	07010113          	addi	sp,sp,112
    8000234c:	00008067          	ret
GENERATE_WRRD(a0);
    80002350:	00000793          	li	a5,0
    80002354:	00078513          	mv	a0,a5
    80002358:	fddff06f          	j	80002334 <_ZN5RISCV22sys_call_thread_createEv+0xb4>

000000008000235c <_ZN5RISCV24sys_call_thread_dispatchEv>:
void RISCV::sys_call_thread_dispatch(){
    8000235c:	fd010113          	addi	sp,sp,-48
    80002360:	02113423          	sd	ra,40(sp)
    80002364:	02813023          	sd	s0,32(sp)
    80002368:	03010413          	addi	s0,sp,48
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    8000236c:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    80002370:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002374:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    80002378:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    8000237c:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002380:	141027f3          	csrr	a5,sepc
    80002384:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80002388:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc() + 4;
    8000238c:	00478793          	addi	a5,a5,4
    80002390:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002394:	100027f3          	csrr	a5,sstatus
    80002398:	fcf43823          	sd	a5,-48(s0)
    8000239c:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    800023a0:	fef43023          	sd	a5,-32(s0)
    TCB::timeSliceCounter = 0;
    800023a4:	0000b797          	auipc	a5,0xb
    800023a8:	86c7b783          	ld	a5,-1940(a5) # 8000cc10 <_GLOBAL_OFFSET_TABLE_+0x20>
    800023ac:	0007b023          	sd	zero,0(a5)
    TCB::dispatch();
    800023b0:	00000593          	li	a1,0
    800023b4:	00100513          	li	a0,1
    800023b8:	00001097          	auipc	ra,0x1
    800023bc:	b1c080e7          	jalr	-1252(ra) # 80002ed4 <_ZN3TCB8dispatchEbP4_sem>
    riscv_csrw_sstatus(sstatus);
    800023c0:	fe043783          	ld	a5,-32(s0)
    800023c4:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    800023c8:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    800023cc:	14179073          	csrw	sepc,a5
}
    800023d0:	02813083          	ld	ra,40(sp)
    800023d4:	02013403          	ld	s0,32(sp)
    800023d8:	03010113          	addi	sp,sp,48
    800023dc:	00008067          	ret

00000000800023e0 <_ZN5RISCV20sys_call_thread_exitEv>:
void RISCV::sys_call_thread_exit(){
    800023e0:	ff010113          	addi	sp,sp,-16
    800023e4:	00113423          	sd	ra,8(sp)
    800023e8:	00813023          	sd	s0,0(sp)
    800023ec:	01010413          	addi	s0,sp,16
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800023f0:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800023f4:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800023f8:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800023fc:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002400:	02043783          	ld	a5,32(s0)
    TCB* running = TCB::running;
    80002404:	0000b797          	auipc	a5,0xb
    80002408:	83c7b783          	ld	a5,-1988(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000240c:	0007b783          	ld	a5,0(a5)
        finished = value;
    80002410:	00100713          	li	a4,1
    80002414:	02e78c23          	sb	a4,56(a5)
    RISCV::sys_call_thread_dispatch();
    80002418:	00000097          	auipc	ra,0x0
    8000241c:	f44080e7          	jalr	-188(ra) # 8000235c <_ZN5RISCV24sys_call_thread_dispatchEv>
};
    80002420:	00813083          	ld	ra,8(sp)
    80002424:	00013403          	ld	s0,0(sp)
    80002428:	01010113          	addi	sp,sp,16
    8000242c:	00008067          	ret

0000000080002430 <_ZN5RISCV20sys_call_thread_joinEv>:
void RISCV::sys_call_thread_join(){
    80002430:	fc010113          	addi	sp,sp,-64
    80002434:	02113c23          	sd	ra,56(sp)
    80002438:	02813823          	sd	s0,48(sp)
    8000243c:	04010413          	addi	s0,sp,64
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    80002440:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    80002444:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002448:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    8000244c:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002450:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002454:	141027f3          	csrr	a5,sepc
    80002458:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    8000245c:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc() + 4;
    80002460:	00478793          	addi	a5,a5,4
    80002464:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002468:	100027f3          	csrr	a5,sstatus
    8000246c:	fcf43823          	sd	a5,-48(s0)
    80002470:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    80002474:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a1);
    80002478:	00058793          	mv	a5,a1
    8000247c:	fcf43423          	sd	a5,-56(s0)
    80002480:	fc843503          	ld	a0,-56(s0)
    other->putAwaiting(TCB::running);
    80002484:	0000a797          	auipc	a5,0xa
    80002488:	7bc7b783          	ld	a5,1980(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000248c:	0007b583          	ld	a1,0(a5)
    80002490:	00001097          	auipc	ra,0x1
    80002494:	b38080e7          	jalr	-1224(ra) # 80002fc8 <_ZN3TCB11putAwaitingEPS_>
    TCB::timeSliceCounter = 0;
    80002498:	0000a797          	auipc	a5,0xa
    8000249c:	7787b783          	ld	a5,1912(a5) # 8000cc10 <_GLOBAL_OFFSET_TABLE_+0x20>
    800024a0:	0007b023          	sd	zero,0(a5)
    TCB::dispatch(false);
    800024a4:	00000593          	li	a1,0
    800024a8:	00000513          	li	a0,0
    800024ac:	00001097          	auipc	ra,0x1
    800024b0:	a28080e7          	jalr	-1496(ra) # 80002ed4 <_ZN3TCB8dispatchEbP4_sem>
    riscv_csrw_sstatus(sstatus);
    800024b4:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    800024b8:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    800024bc:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    800024c0:	14179073          	csrw	sepc,a5
};
    800024c4:	03813083          	ld	ra,56(sp)
    800024c8:	03013403          	ld	s0,48(sp)
    800024cc:	04010113          	addi	sp,sp,64
    800024d0:	00008067          	ret

00000000800024d4 <_ZN5RISCV17sys_call_sem_openEv>:
void RISCV::sys_call_sem_open(){
    800024d4:	fb010113          	addi	sp,sp,-80
    800024d8:	04113423          	sd	ra,72(sp)
    800024dc:	04813023          	sd	s0,64(sp)
    800024e0:	02913c23          	sd	s1,56(sp)
    800024e4:	03213823          	sd	s2,48(sp)
    800024e8:	05010413          	addi	s0,sp,80
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800024ec:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800024f0:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800024f4:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800024f8:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    800024fc:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002500:	141027f3          	csrr	a5,sepc
    80002504:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    80002508:	fc843783          	ld	a5,-56(s0)
    uint64 volatile sepc = r_sepc() + 4;
    8000250c:	00478793          	addi	a5,a5,4
    80002510:	fcf43c23          	sd	a5,-40(s0)
GENERATE_CSR(sstatus);
    80002514:	100027f3          	csrr	a5,sstatus
    80002518:	fcf43023          	sd	a5,-64(s0)
    8000251c:	fc043783          	ld	a5,-64(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    80002520:	fcf43823          	sd	a5,-48(s0)
GENERATE_WRRD(a1);
    80002524:	00058793          	mv	a5,a1
    80002528:	faf43c23          	sd	a5,-72(s0)
    8000252c:	fb843903          	ld	s2,-72(s0)
GENERATE_WRRD(a2);
    80002530:	00060793          	mv	a5,a2
    80002534:	faf43823          	sd	a5,-80(s0)
    80002538:	fb043483          	ld	s1,-80(s0)
    sem_t sem = new _sem(init);
    8000253c:	02000513          	li	a0,32
    80002540:	00001097          	auipc	ra,0x1
    80002544:	094080e7          	jalr	148(ra) # 800035d4 <_ZN4_semnwEm>
    80002548:	03049493          	slli	s1,s1,0x30
    8000254c:	0304d493          	srli	s1,s1,0x30
    80002550:	00952023          	sw	s1,0(a0)
    80002554:	00053423          	sd	zero,8(a0)
    80002558:	00053823          	sd	zero,16(a0)
    8000255c:	00053c23          	sd	zero,24(a0)
    if(!sem){
    80002560:	02050c63          	beqz	a0,80002598 <_ZN5RISCV17sys_call_sem_openEv+0xc4>
        *(handle) = sem;
    80002564:	00a93023          	sd	a0,0(s2)
GENERATE_WRRD(a0);
    80002568:	00000793          	li	a5,0
    8000256c:	00078513          	mv	a0,a5
    riscv_csrw_sstatus(sstatus);
    80002570:	fd043783          	ld	a5,-48(s0)
GENERATE_CSR(sstatus);
    80002574:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    80002578:	fd843783          	ld	a5,-40(s0)
GENERATE_CSR(sepc);
    8000257c:	14179073          	csrw	sepc,a5
}
    80002580:	04813083          	ld	ra,72(sp)
    80002584:	04013403          	ld	s0,64(sp)
    80002588:	03813483          	ld	s1,56(sp)
    8000258c:	03013903          	ld	s2,48(sp)
    80002590:	05010113          	addi	sp,sp,80
    80002594:	00008067          	ret
GENERATE_WRRD(a0);
    80002598:	fff00793          	li	a5,-1
    8000259c:	00078513          	mv	a0,a5
    800025a0:	fd1ff06f          	j	80002570 <_ZN5RISCV17sys_call_sem_openEv+0x9c>

00000000800025a4 <_ZN5RISCV18sys_call_sem_closeEv>:
void RISCV::sys_call_sem_close(){
    800025a4:	fb010113          	addi	sp,sp,-80
    800025a8:	04113423          	sd	ra,72(sp)
    800025ac:	04813023          	sd	s0,64(sp)
    800025b0:	02913c23          	sd	s1,56(sp)
    800025b4:	05010413          	addi	s0,sp,80
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800025b8:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800025bc:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800025c0:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800025c4:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    800025c8:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800025cc:	141027f3          	csrr	a5,sepc
    800025d0:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    800025d4:	fc843783          	ld	a5,-56(s0)
    uint64 volatile sepc = r_sepc() + 4;
    800025d8:	00478793          	addi	a5,a5,4
    800025dc:	fcf43c23          	sd	a5,-40(s0)
GENERATE_CSR(sstatus);
    800025e0:	100027f3          	csrr	a5,sstatus
    800025e4:	fcf43023          	sd	a5,-64(s0)
    800025e8:	fc043783          	ld	a5,-64(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    800025ec:	fcf43823          	sd	a5,-48(s0)
GENERATE_WRRD(a1);
    800025f0:	00058793          	mv	a5,a1
    800025f4:	faf43c23          	sd	a5,-72(s0)
    800025f8:	fb843483          	ld	s1,-72(s0)
    if(!id){
    800025fc:	02049863          	bnez	s1,8000262c <_ZN5RISCV18sys_call_sem_closeEv+0x88>
GENERATE_WRRD(a0);
    80002600:	fff00793          	li	a5,-1
    80002604:	00078513          	mv	a0,a5
    riscv_csrw_sstatus(sstatus);
    80002608:	fd043783          	ld	a5,-48(s0)
GENERATE_CSR(sstatus);
    8000260c:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    80002610:	fd843783          	ld	a5,-40(s0)
GENERATE_CSR(sepc);
    80002614:	14179073          	csrw	sepc,a5
}
    80002618:	04813083          	ld	ra,72(sp)
    8000261c:	04013403          	ld	s0,64(sp)
    80002620:	03813483          	ld	s1,56(sp)
    80002624:	05010113          	addi	sp,sp,80
    80002628:	00008067          	ret
        delete id;
    8000262c:	00048513          	mv	a0,s1
    80002630:	00001097          	auipc	ra,0x1
    80002634:	010080e7          	jalr	16(ra) # 80003640 <_ZN4_semD1Ev>
    80002638:	00048513          	mv	a0,s1
    8000263c:	00001097          	auipc	ra,0x1
    80002640:	fdc080e7          	jalr	-36(ra) # 80003618 <_ZN4_semdlEPv>
GENERATE_WRRD(a0);
    80002644:	00100793          	li	a5,1
    80002648:	00078513          	mv	a0,a5
    8000264c:	fbdff06f          	j	80002608 <_ZN5RISCV18sys_call_sem_closeEv+0x64>

0000000080002650 <_ZN5RISCV17sys_call_sem_waitEv>:
void RISCV::sys_call_sem_wait(){
    80002650:	fc010113          	addi	sp,sp,-64
    80002654:	02113c23          	sd	ra,56(sp)
    80002658:	02813823          	sd	s0,48(sp)
    8000265c:	04010413          	addi	s0,sp,64
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    80002660:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    80002664:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002668:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    8000266c:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002670:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002674:	141027f3          	csrr	a5,sepc
    80002678:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    8000267c:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc() + 4;
    80002680:	00478793          	addi	a5,a5,4
    80002684:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002688:	100027f3          	csrr	a5,sstatus
    8000268c:	fcf43823          	sd	a5,-48(s0)
    80002690:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    80002694:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a1);
    80002698:	00058793          	mv	a5,a1
    8000269c:	fcf43423          	sd	a5,-56(s0)
    800026a0:	fc843503          	ld	a0,-56(s0)
    uint64 code = handle->wait();
    800026a4:	00001097          	auipc	ra,0x1
    800026a8:	dc8080e7          	jalr	-568(ra) # 8000346c <_ZN4_sem4waitEv>
GENERATE_WRRD(a0);
    800026ac:	00050513          	mv	a0,a0
    riscv_csrw_sstatus(sstatus);
    800026b0:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    800026b4:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    800026b8:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    800026bc:	14179073          	csrw	sepc,a5
};
    800026c0:	03813083          	ld	ra,56(sp)
    800026c4:	03013403          	ld	s0,48(sp)
    800026c8:	04010113          	addi	sp,sp,64
    800026cc:	00008067          	ret

00000000800026d0 <_ZN5RISCV19sys_call_sem_signalEv>:
void RISCV::sys_call_sem_signal() {
    800026d0:	fc010113          	addi	sp,sp,-64
    800026d4:	02113c23          	sd	ra,56(sp)
    800026d8:	02813823          	sd	s0,48(sp)
    800026dc:	04010413          	addi	s0,sp,64
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800026e0:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800026e4:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800026e8:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800026ec:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    800026f0:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800026f4:	141027f3          	csrr	a5,sepc
    800026f8:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    800026fc:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc() + 4;
    80002700:	00478793          	addi	a5,a5,4
    80002704:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002708:	100027f3          	csrr	a5,sstatus
    8000270c:	fcf43823          	sd	a5,-48(s0)
    80002710:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    80002714:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a1);
    80002718:	00058793          	mv	a5,a1
    8000271c:	fcf43423          	sd	a5,-56(s0)
    80002720:	fc843503          	ld	a0,-56(s0)
    uint64 code = handle->signal();
    80002724:	00001097          	auipc	ra,0x1
    80002728:	e38080e7          	jalr	-456(ra) # 8000355c <_ZN4_sem6signalEv>
GENERATE_WRRD(a0);
    8000272c:	00050513          	mv	a0,a0
    riscv_csrw_sstatus(sstatus);
    80002730:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    80002734:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    80002738:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    8000273c:	14179073          	csrw	sepc,a5
}
    80002740:	03813083          	ld	ra,56(sp)
    80002744:	03013403          	ld	s0,48(sp)
    80002748:	04010113          	addi	sp,sp,64
    8000274c:	00008067          	ret

0000000080002750 <_ZN5RISCV19sys_call_time_sleepEv>:
void RISCV::sys_call_time_sleep()  {
    80002750:	fc010113          	addi	sp,sp,-64
    80002754:	02113c23          	sd	ra,56(sp)
    80002758:	02813823          	sd	s0,48(sp)
    8000275c:	04010413          	addi	s0,sp,64
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    80002760:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    80002764:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002768:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    8000276c:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002770:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002774:	141027f3          	csrr	a5,sepc
    80002778:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    8000277c:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc() + 4;
    80002780:	00478793          	addi	a5,a5,4
    80002784:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002788:	100027f3          	csrr	a5,sstatus
    8000278c:	fcf43823          	sd	a5,-48(s0)
    80002790:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    80002794:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a1);
    80002798:	00058793          	mv	a5,a1
    8000279c:	fcf43423          	sd	a5,-56(s0)
    800027a0:	fc843503          	ld	a0,-56(s0)
    TCB::sleep(time);
    800027a4:	00001097          	auipc	ra,0x1
    800027a8:	88c080e7          	jalr	-1908(ra) # 80003030 <_ZN3TCB5sleepEm>
    riscv_csrw_sstatus(sstatus);
    800027ac:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    800027b0:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    800027b4:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    800027b8:	14179073          	csrw	sepc,a5
}
    800027bc:	03813083          	ld	ra,56(sp)
    800027c0:	03013403          	ld	s0,48(sp)
    800027c4:	04010113          	addi	sp,sp,64
    800027c8:	00008067          	ret

00000000800027cc <_ZN5RISCV13sys_call_getcEv>:
void RISCV::sys_call_getc(){
    800027cc:	fd010113          	addi	sp,sp,-48
    800027d0:	02113423          	sd	ra,40(sp)
    800027d4:	02813023          	sd	s0,32(sp)
    800027d8:	03010413          	addi	s0,sp,48
    static void contextSwitch(Context * oldContext, Context * runningContext);

    static void dispatch(bool putInScheduler=true, _sem* lockedSem=nullptr);

    static void switchSupervisorMode(){
        TCB::running->supervisorMode= (TCB::running)->supervisorMode==0?1:0;
    800027dc:	0000a797          	auipc	a5,0xa
    800027e0:	4647b783          	ld	a5,1124(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    800027e4:	0007b783          	ld	a5,0(a5)
    800027e8:	0287b703          	ld	a4,40(a5)
    800027ec:	08071663          	bnez	a4,80002878 <_ZN5RISCV13sys_call_getcEv+0xac>
    800027f0:	00100713          	li	a4,1
    800027f4:	02e7b423          	sd	a4,40(a5)
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800027f8:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800027fc:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    80002800:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    80002804:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    80002808:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000280c:	141027f3          	csrr	a5,sepc
    80002810:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80002814:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc()+4;
    80002818:	00478793          	addi	a5,a5,4
    8000281c:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    80002820:	100027f3          	csrr	a5,sstatus
    80002824:	fcf43823          	sd	a5,-48(s0)
    80002828:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    8000282c:	fef43023          	sd	a5,-32(s0)
    char c = __getc();
    80002830:	00007097          	auipc	ra,0x7
    80002834:	ac8080e7          	jalr	-1336(ra) # 800092f8 <__getc>
GENERATE_WRRD(a0);
    80002838:	00050513          	mv	a0,a0
    riscv_csrw_sepc(sepc);
    8000283c:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    80002840:	14179073          	csrw	sepc,a5
    riscv_csrw_sstatus(sstatus);
    80002844:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    80002848:	10079073          	csrw	sstatus,a5
    8000284c:	0000a797          	auipc	a5,0xa
    80002850:	3f47b783          	ld	a5,1012(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002854:	0007b783          	ld	a5,0(a5)
    80002858:	0287b703          	ld	a4,40(a5)
    8000285c:	02071263          	bnez	a4,80002880 <_ZN5RISCV13sys_call_getcEv+0xb4>
    80002860:	00100713          	li	a4,1
    80002864:	02e7b423          	sd	a4,40(a5)
}
    80002868:	02813083          	ld	ra,40(sp)
    8000286c:	02013403          	ld	s0,32(sp)
    80002870:	03010113          	addi	sp,sp,48
    80002874:	00008067          	ret
    80002878:	00000713          	li	a4,0
    8000287c:	f79ff06f          	j	800027f4 <_ZN5RISCV13sys_call_getcEv+0x28>
    80002880:	00000713          	li	a4,0
    80002884:	fe1ff06f          	j	80002864 <_ZN5RISCV13sys_call_getcEv+0x98>

0000000080002888 <_ZN5RISCV13sys_call_putcEv>:
void RISCV::sys_call_putc(){
    80002888:	fc010113          	addi	sp,sp,-64
    8000288c:	02113c23          	sd	ra,56(sp)
    80002890:	02813823          	sd	s0,48(sp)
    80002894:	04010413          	addi	s0,sp,64
    80002898:	0000a797          	auipc	a5,0xa
    8000289c:	3a87b783          	ld	a5,936(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    800028a0:	0007b783          	ld	a5,0(a5)
    800028a4:	0287b703          	ld	a4,40(a5)
    800028a8:	08071c63          	bnez	a4,80002940 <_ZN5RISCV13sys_call_putcEv+0xb8>
    800028ac:	00100713          	li	a4,1
    800028b0:	02e7b423          	sd	a4,40(a5)
        __asm__ volatile ("ld a1, 0 * 8(fp)");
    800028b4:	00043583          	ld	a1,0(s0)
        __asm__ volatile ("ld a2, 1 * 8(fp)");
    800028b8:	00843603          	ld	a2,8(s0)
        __asm__ volatile ("ld a3, 2 * 8(fp)");
    800028bc:	01043683          	ld	a3,16(s0)
        __asm__ volatile ("ld a4, 3 * 8(fp)");
    800028c0:	01843703          	ld	a4,24(s0)
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    800028c4:	02043783          	ld	a5,32(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800028c8:	141027f3          	csrr	a5,sepc
    800028cc:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    800028d0:	fd843783          	ld	a5,-40(s0)
    uint64 volatile sepc = r_sepc() + 4;
    800028d4:	00478793          	addi	a5,a5,4
    800028d8:	fef43423          	sd	a5,-24(s0)
GENERATE_CSR(sstatus);
    800028dc:	100027f3          	csrr	a5,sstatus
    800028e0:	fcf43823          	sd	a5,-48(s0)
    800028e4:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sstatus = riscv_csrr_sstatus();
    800028e8:	fef43023          	sd	a5,-32(s0)
GENERATE_WRRD(a1);
    800028ec:	00058793          	mv	a5,a1
    800028f0:	fcf43423          	sd	a5,-56(s0)
    800028f4:	fc843503          	ld	a0,-56(s0)
    __putc(c);
    800028f8:	0ff57513          	andi	a0,a0,255
    800028fc:	00007097          	auipc	ra,0x7
    80002900:	9c0080e7          	jalr	-1600(ra) # 800092bc <__putc>
    riscv_csrw_sstatus(sstatus);
    80002904:	fe043783          	ld	a5,-32(s0)
GENERATE_CSR(sstatus);
    80002908:	10079073          	csrw	sstatus,a5
    riscv_csrw_sepc(sepc);
    8000290c:	fe843783          	ld	a5,-24(s0)
GENERATE_CSR(sepc);
    80002910:	14179073          	csrw	sepc,a5
    80002914:	0000a797          	auipc	a5,0xa
    80002918:	32c7b783          	ld	a5,812(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000291c:	0007b783          	ld	a5,0(a5)
    80002920:	0287b703          	ld	a4,40(a5)
    80002924:	02071263          	bnez	a4,80002948 <_ZN5RISCV13sys_call_putcEv+0xc0>
    80002928:	00100713          	li	a4,1
    8000292c:	02e7b423          	sd	a4,40(a5)
}
    80002930:	03813083          	ld	ra,56(sp)
    80002934:	03013403          	ld	s0,48(sp)
    80002938:	04010113          	addi	sp,sp,64
    8000293c:	00008067          	ret
    80002940:	00000713          	li	a4,0
    80002944:	f6dff06f          	j	800028b0 <_ZN5RISCV13sys_call_putcEv+0x28>
    80002948:	00000713          	li	a4,0
    8000294c:	fe1ff06f          	j	8000292c <_ZN5RISCV13sys_call_putcEv+0xa4>

0000000080002950 <_ZN5RISCV21switchToUserLevelModeEv>:
void RISCV::switchToUserLevelMode() {
    80002950:	ff010113          	addi	sp,sp,-16
    80002954:	00813423          	sd	s0,8(sp)
    80002958:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv %0, ra": "=r" (ra));
    8000295c:	00008793          	mv	a5,ra
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80002960:	10000713          	li	a4,256
    80002964:	10073073          	csrc	sstatus,a4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(ra));
    80002968:	14179073          	csrw	sepc,a5
    __asm__ volatile("ld s0,8(sp)");
    8000296c:	00813403          	ld	s0,8(sp)
    __asm__ volatile("addi sp,sp,16");
    80002970:	01010113          	addi	sp,sp,16
    __asm__ volatile("sret");
    80002974:	10200073          	sret
}
    80002978:	00813403          	ld	s0,8(sp)
    8000297c:	01010113          	addi	sp,sp,16
    80002980:	00008067          	ret

0000000080002984 <_ZN5RISCV10popSppSpieEv>:
{
    80002984:	ff010113          	addi	sp,sp,-16
    80002988:	00813423          	sd	s0,8(sp)
    8000298c:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80002990:	14109073          	csrw	sepc,ra
    __asm__ volatile("call restoreContext");
    80002994:	ffffe097          	auipc	ra,0xffffe
    80002998:	66c080e7          	jalr	1644(ra) # 80001000 <restoreContext>
}
    8000299c:	00813403          	ld	s0,8(sp)
    800029a0:	01010113          	addi	sp,sp,16
    800029a4:	00008067          	ret

00000000800029a8 <_ZN5RISCV20handleSupervisorTrapEv>:

};


void RISCV::handleSupervisorTrap()
{
    800029a8:	fb010113          	addi	sp,sp,-80
    800029ac:	04113423          	sd	ra,72(sp)
    800029b0:	04813023          	sd	s0,64(sp)
    800029b4:	02913c23          	sd	s1,56(sp)
    800029b8:	05010413          	addi	s0,sp,80
        __asm__ volatile ("addi sp, sp, -40");
    800029bc:	fd810113          	addi	sp,sp,-40
        __asm__ volatile ("sd a1, 0 * 8(sp)");
    800029c0:	00b13023          	sd	a1,0(sp)
        __asm__ volatile ("sd a2, 1 * 8(sp)");
    800029c4:	00c13423          	sd	a2,8(sp)
        __asm__ volatile ("sd a3, 2 * 8(sp)");
    800029c8:	00d13823          	sd	a3,16(sp)
        __asm__ volatile ("sd a4, 3 * 8(sp)");
    800029cc:	00e13c23          	sd	a4,24(sp)
        __asm__ volatile ("sd a5, 4 * 8(sp)");
    800029d0:	02f13023          	sd	a5,32(sp)
GENERATE_CSR(scause);
    800029d4:	142027f3          	csrr	a5,scause
    800029d8:	fcf43423          	sd	a5,-56(s0)
    800029dc:	fc843483          	ld	s1,-56(s0)
    saveArguments();

    uint64 scause = riscv_csrr_scause();

    switch(scause){
    800029e0:	00900793          	li	a5,9
    800029e4:	0497e663          	bltu	a5,s1,80002a30 <_ZN5RISCV20handleSupervisorTrapEv+0x88>
    800029e8:	00800793          	li	a5,8
    800029ec:	06f4f463          	bgeu	s1,a5,80002a54 <_ZN5RISCV20handleSupervisorTrapEv+0xac>
    800029f0:	00500793          	li	a5,5
    800029f4:	0af48463          	beq	s1,a5,80002a9c <_ZN5RISCV20handleSupervisorTrapEv+0xf4>
    800029f8:	00700793          	li	a5,7
    800029fc:	0af48063          	beq	s1,a5,80002a9c <_ZN5RISCV20handleSupervisorTrapEv+0xf4>
    80002a00:	00200793          	li	a5,2
    80002a04:	0af49663          	bne	s1,a5,80002ab0 <_ZN5RISCV20handleSupervisorTrapEv+0x108>
        case RISCV_SCAUSE_ILLEGAL_INSTRUCTION: {
            printString("Illegal Instruction\n");
    80002a08:	00007517          	auipc	a0,0x7
    80002a0c:	61850513          	addi	a0,a0,1560 # 8000a020 <CONSOLE_STATUS+0x10>
    80002a10:	00003097          	auipc	ra,0x3
    80002a14:	5a0080e7          	jalr	1440(ra) # 80005fb0 <_Z11printStringPKc>
            printInt(scause);
            printString("-------------------------\n");
            break;
        }
    };
    __asm__ volatile ("addi sp, sp, 40");
    80002a18:	02810113          	addi	sp,sp,40
}
    80002a1c:	04813083          	ld	ra,72(sp)
    80002a20:	04013403          	ld	s0,64(sp)
    80002a24:	03813483          	ld	s1,56(sp)
    80002a28:	05010113          	addi	sp,sp,80
    80002a2c:	00008067          	ret
    switch(scause){
    80002a30:	fff00793          	li	a5,-1
    80002a34:	03f79793          	slli	a5,a5,0x3f
    80002a38:	00978793          	addi	a5,a5,9
    80002a3c:	06f49a63          	bne	s1,a5,80002ab0 <_ZN5RISCV20handleSupervisorTrapEv+0x108>
            printString("Should not happen in this routine.\n");
    80002a40:	00007517          	auipc	a0,0x7
    80002a44:	5f850513          	addi	a0,a0,1528 # 8000a038 <CONSOLE_STATUS+0x28>
    80002a48:	00003097          	auipc	ra,0x3
    80002a4c:	568080e7          	jalr	1384(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80002a50:	fc9ff06f          	j	80002a18 <_ZN5RISCV20handleSupervisorTrapEv+0x70>
GENERATE_WRRD(a0);
    80002a54:	00050793          	mv	a5,a0
    80002a58:	fcf43c23          	sd	a5,-40(s0)
    80002a5c:	fd843783          	ld	a5,-40(s0)
            uint64 volatile syscall_code =riscv_rd_a0();
    80002a60:	faf43c23          	sd	a5,-72(s0)
            pf[syscall_code]();
    80002a64:	fb843783          	ld	a5,-72(s0)
    80002a68:	00379713          	slli	a4,a5,0x3
    80002a6c:	0000a797          	auipc	a5,0xa
    80002a70:	dc478793          	addi	a5,a5,-572 # 8000c830 <_ZN5RISCV2pfE>
    80002a74:	00e787b3          	add	a5,a5,a4
    80002a78:	0007b783          	ld	a5,0(a5)
    80002a7c:	000780e7          	jalr	a5
    80002a80:	00050793          	mv	a5,a0
    80002a84:	fcf43823          	sd	a5,-48(s0)
    80002a88:	fd043783          	ld	a5,-48(s0)
            uint64 volatile a0 = riscv_rd_a0();
    80002a8c:	fcf43023          	sd	a5,-64(s0)
            __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));
    80002a90:	fc043783          	ld	a5,-64(s0)
    80002a94:	04f43823          	sd	a5,80(s0)
            break;
    80002a98:	f81ff06f          	j	80002a18 <_ZN5RISCV20handleSupervisorTrapEv+0x70>
            printString("Illegal Memmory\n");
    80002a9c:	00007517          	auipc	a0,0x7
    80002aa0:	5c450513          	addi	a0,a0,1476 # 8000a060 <CONSOLE_STATUS+0x50>
    80002aa4:	00003097          	auipc	ra,0x3
    80002aa8:	50c080e7          	jalr	1292(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80002aac:	f6dff06f          	j	80002a18 <_ZN5RISCV20handleSupervisorTrapEv+0x70>
            printString("-------------------------\n");
    80002ab0:	00007517          	auipc	a0,0x7
    80002ab4:	5c850513          	addi	a0,a0,1480 # 8000a078 <CONSOLE_STATUS+0x68>
    80002ab8:	00003097          	auipc	ra,0x3
    80002abc:	4f8080e7          	jalr	1272(ra) # 80005fb0 <_Z11printStringPKc>
            printString("FATAL ERROR\n");
    80002ac0:	00007517          	auipc	a0,0x7
    80002ac4:	5d850513          	addi	a0,a0,1496 # 8000a098 <CONSOLE_STATUS+0x88>
    80002ac8:	00003097          	auipc	ra,0x3
    80002acc:	4e8080e7          	jalr	1256(ra) # 80005fb0 <_Z11printStringPKc>
            printString("Scause=");
    80002ad0:	00007517          	auipc	a0,0x7
    80002ad4:	5d850513          	addi	a0,a0,1496 # 8000a0a8 <CONSOLE_STATUS+0x98>
    80002ad8:	00003097          	auipc	ra,0x3
    80002adc:	4d8080e7          	jalr	1240(ra) # 80005fb0 <_Z11printStringPKc>
            printInt(scause);
    80002ae0:	00000613          	li	a2,0
    80002ae4:	00a00593          	li	a1,10
    80002ae8:	0004851b          	sext.w	a0,s1
    80002aec:	00003097          	auipc	ra,0x3
    80002af0:	674080e7          	jalr	1652(ra) # 80006160 <_Z8printIntiii>
            printString("-------------------------\n");
    80002af4:	00007517          	auipc	a0,0x7
    80002af8:	58450513          	addi	a0,a0,1412 # 8000a078 <CONSOLE_STATUS+0x68>
    80002afc:	00003097          	auipc	ra,0x3
    80002b00:	4b4080e7          	jalr	1204(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80002b04:	f15ff06f          	j	80002a18 <_ZN5RISCV20handleSupervisorTrapEv+0x70>

0000000080002b08 <_ZN5RISCV33handleSupervisorSoftwareInterruptEv>:

void RISCV::handleSupervisorSoftwareInterrupt(){
    80002b08:	fb010113          	addi	sp,sp,-80
    80002b0c:	04113423          	sd	ra,72(sp)
    80002b10:	04813023          	sd	s0,64(sp)
    80002b14:	02913c23          	sd	s1,56(sp)
    80002b18:	05010413          	addi	s0,sp,80
GENERATE_CSR(scause);
    80002b1c:	142027f3          	csrr	a5,scause
    80002b20:	fcf43423          	sd	a5,-56(s0)
    80002b24:	fc843703          	ld	a4,-56(s0)
    uint64 scause = riscv_csrr_scause();

    switch(scause){
    80002b28:	fff00793          	li	a5,-1
    80002b2c:	03f79793          	slli	a5,a5,0x3f
    80002b30:	00178793          	addi	a5,a5,1
    80002b34:	00f70c63          	beq	a4,a5,80002b4c <_ZN5RISCV33handleSupervisorSoftwareInterruptEv+0x44>
        default: {

            break;
        }
    }
}
    80002b38:	04813083          	ld	ra,72(sp)
    80002b3c:	04013403          	ld	s0,64(sp)
    80002b40:	03813483          	ld	s1,56(sp)
    80002b44:	05010113          	addi	sp,sp,80
    80002b48:	00008067          	ret
GENERATE_CSR(sip);
    80002b4c:	00200793          	li	a5,2
    80002b50:	1447b073          	csrc	sip,a5
            TCB::timeSliceCounter++;
    80002b54:	0000a497          	auipc	s1,0xa
    80002b58:	0bc4b483          	ld	s1,188(s1) # 8000cc10 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002b5c:	0004b783          	ld	a5,0(s1)
    80002b60:	00178793          	addi	a5,a5,1
    80002b64:	00f4b023          	sd	a5,0(s1)
            TCB::wakeThreads();
    80002b68:	00000097          	auipc	ra,0x0
    80002b6c:	5cc080e7          	jalr	1484(ra) # 80003134 <_ZN3TCB11wakeThreadsEv>
            if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
    80002b70:	0000a797          	auipc	a5,0xa
    80002b74:	0d07b783          	ld	a5,208(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002b78:	0007b783          	ld	a5,0(a5)
        return timeSlice;
    80002b7c:	0307b783          	ld	a5,48(a5)
    80002b80:	0004b703          	ld	a4,0(s1)
    80002b84:	faf76ae3          	bltu	a4,a5,80002b38 <_ZN5RISCV33handleSupervisorSoftwareInterruptEv+0x30>
GENERATE_CSR(sepc);
    80002b88:	141027f3          	csrr	a5,sepc
    80002b8c:	fcf43c23          	sd	a5,-40(s0)
    80002b90:	fd843783          	ld	a5,-40(s0)
                uint64 volatile sepc = riscv_csrr_sepc();
    80002b94:	faf43c23          	sd	a5,-72(s0)
GENERATE_CSR(sstatus);
    80002b98:	100027f3          	csrr	a5,sstatus
    80002b9c:	fcf43823          	sd	a5,-48(s0)
    80002ba0:	fd043783          	ld	a5,-48(s0)
                uint64 volatile sstatus = riscv_csrr_sstatus();
    80002ba4:	fcf43023          	sd	a5,-64(s0)
                TCB::timeSliceCounter = 0;
    80002ba8:	0004b023          	sd	zero,0(s1)
                TCB::dispatch();
    80002bac:	00000593          	li	a1,0
    80002bb0:	00100513          	li	a0,1
    80002bb4:	00000097          	auipc	ra,0x0
    80002bb8:	320080e7          	jalr	800(ra) # 80002ed4 <_ZN3TCB8dispatchEbP4_sem>
                riscv_csrw_sstatus(sstatus);
    80002bbc:	fc043783          	ld	a5,-64(s0)
    80002bc0:	10079073          	csrw	sstatus,a5
                riscv_csrw_sepc(sepc);
    80002bc4:	fb843783          	ld	a5,-72(s0)
GENERATE_CSR(sepc);
    80002bc8:	14179073          	csrw	sepc,a5
}
    80002bcc:	f6dff06f          	j	80002b38 <_ZN5RISCV33handleSupervisorSoftwareInterruptEv+0x30>

0000000080002bd0 <_ZN5RISCV33handleSupervisorHardwareInterruptEv>:



void RISCV::handleSupervisorHardwareInterrupt(){
    80002bd0:	ff010113          	addi	sp,sp,-16
    80002bd4:	00113423          	sd	ra,8(sp)
    80002bd8:	00813023          	sd	s0,0(sp)
    80002bdc:	01010413          	addi	s0,sp,16
    console_handler();
    80002be0:	00006097          	auipc	ra,0x6
    80002be4:	750080e7          	jalr	1872(ra) # 80009330 <console_handler>
            char c = (*(char*)CONSOLE_RX_DATA);
            inputBuffer->send(c);
        }
    }
    plic_complete(claim);*/
}
    80002be8:	00813083          	ld	ra,8(sp)
    80002bec:	00013403          	ld	s0,0(sp)
    80002bf0:	01010113          	addi	sp,sp,16
    80002bf4:	00008067          	ret

0000000080002bf8 <_Z41__static_initialization_and_destruction_0ii>:
        while((*((char*)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT)){
            char c = outputBuffer->receiveSys();
            *((char*)CONSOLE_TX_DATA) = c;
        }
    }
}
    80002bf8:	ff010113          	addi	sp,sp,-16
    80002bfc:	00813423          	sd	s0,8(sp)
    80002c00:	01010413          	addi	s0,sp,16
    80002c04:	00100793          	li	a5,1
    80002c08:	00f50863          	beq	a0,a5,80002c18 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002c0c:	00813403          	ld	s0,8(sp)
    80002c10:	01010113          	addi	sp,sp,16
    80002c14:	00008067          	ret
    80002c18:	000107b7          	lui	a5,0x10
    80002c1c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002c20:	fef596e3          	bne	a1,a5,80002c0c <_Z41__static_initialization_and_destruction_0ii+0x14>
    80002c24:	0000a797          	auipc	a5,0xa
    80002c28:	0cc78793          	addi	a5,a5,204 # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
    80002c2c:	0007b023          	sd	zero,0(a5)
    80002c30:	0007b423          	sd	zero,8(a5)
    80002c34:	fd9ff06f          	j	80002c0c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002c38 <_ZN3TCBnwEmPv>:
void*::TCB::operator new(size_t size, void *memory) {
    80002c38:	ff010113          	addi	sp,sp,-16
    80002c3c:	00813423          	sd	s0,8(sp)
    80002c40:	01010413          	addi	s0,sp,16
}
    80002c44:	00058513          	mv	a0,a1
    80002c48:	00813403          	ld	s0,8(sp)
    80002c4c:	01010113          	addi	sp,sp,16
    80002c50:	00008067          	ret

0000000080002c54 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *ptr) {
    80002c54:	ff010113          	addi	sp,sp,-16
    80002c58:	00113423          	sd	ra,8(sp)
    80002c5c:	00813023          	sd	s0,0(sp)
    80002c60:	01010413          	addi	s0,sp,16
    MemoryAllocator::free(ptr);
    80002c64:	00001097          	auipc	ra,0x1
    80002c68:	d24080e7          	jalr	-732(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
}
    80002c6c:	00813083          	ld	ra,8(sp)
    80002c70:	00013403          	ld	s0,0(sp)
    80002c74:	01010113          	addi	sp,sp,16
    80002c78:	00008067          	ret

0000000080002c7c <_ZN3TCBC1EPFvPvES0_PmS3_mb>:
    80002c7c:	04053423          	sd	zero,72(a0)
    80002c80:	04053823          	sd	zero,80(a0)
TCB::TCB(Body body, void* args, uint64* stack_space, uint64* kernel_stack_space, uint64 timeSlice, bool putInScheduler) {
    80002c84:	04050ca3          	sb	zero,89(a0)
    this -> body = body;
    80002c88:	00b53023          	sd	a1,0(a0)
    this -> args = args;
    80002c8c:	02c53023          	sd	a2,32(a0)
    this -> stack = stack_space;
    80002c90:	00d53423          	sd	a3,8(a0)
    this -> timeSlice = timeSlice;
    80002c94:	02f53823          	sd	a5,48(a0)
    this -> finished = false;
    80002c98:	02050c23          	sb	zero,56(a0)
    this -> semaphoreDestroyed = false;
    80002c9c:	04050c23          	sb	zero,88(a0)
    this -> scheduled = putInScheduler;
    80002ca0:	05050d23          	sb	a6,90(a0)
    this -> supervisorMode = 0;
    80002ca4:	02053423          	sd	zero,40(a0)
    kernelStack = kernel_stack_space;
    80002ca8:	00e53823          	sd	a4,16(a0)
            (uint64) & kernelStack[KERNEL_STACK_SIZE]
    80002cac:	000027b7          	lui	a5,0x2
    80002cb0:	00f70733          	add	a4,a4,a5
    context.kernelStackPointer -= 256;
    80002cb4:	f0070793          	addi	a5,a4,-256
    80002cb8:	00f53c23          	sd	a5,24(a0)
    *((uint64 * )(context.kernelStackPointer + 8)) = (uint64) & threadWrapper; //ra
    80002cbc:	00000797          	auipc	a5,0x0
    80002cc0:	17878793          	addi	a5,a5,376 # 80002e34 <_ZN3TCB13threadWrapperEv>
    80002cc4:	f0f73423          	sd	a5,-248(a4)
    *((uint64 * )(context.kernelStackPointer + 16)) = (stack != nullptr) ? (uint64) & stack[DEFAULT_STACK_SIZE]: 0; //sp
    80002cc8:	00853783          	ld	a5,8(a0)
    80002ccc:	02078063          	beqz	a5,80002cec <_ZN3TCBC1EPFvPvES0_PmS3_mb+0x70>
    80002cd0:	00008737          	lui	a4,0x8
    80002cd4:	00e787b3          	add	a5,a5,a4
    80002cd8:	01853703          	ld	a4,24(a0)
    80002cdc:	00f73823          	sd	a5,16(a4) # 8010 <_entry-0x7fff7ff0>
    if (body != nullptr && putInScheduler==true) {
    80002ce0:	00058463          	beqz	a1,80002ce8 <_ZN3TCBC1EPFvPvES0_PmS3_mb+0x6c>
    80002ce4:	00081863          	bnez	a6,80002cf4 <_ZN3TCBC1EPFvPvES0_PmS3_mb+0x78>
    80002ce8:	00008067          	ret
    *((uint64 * )(context.kernelStackPointer + 16)) = (stack != nullptr) ? (uint64) & stack[DEFAULT_STACK_SIZE]: 0; //sp
    80002cec:	00000793          	li	a5,0
    80002cf0:	fe9ff06f          	j	80002cd8 <_ZN3TCBC1EPFvPvES0_PmS3_mb+0x5c>
TCB::TCB(Body body, void* args, uint64* stack_space, uint64* kernel_stack_space, uint64 timeSlice, bool putInScheduler) {
    80002cf4:	ff010113          	addi	sp,sp,-16
    80002cf8:	00113423          	sd	ra,8(sp)
    80002cfc:	00813023          	sd	s0,0(sp)
    80002d00:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    80002d04:	fffff097          	auipc	ra,0xfffff
    80002d08:	c90080e7          	jalr	-880(ra) # 80001994 <_ZN9Scheduler3putEP3TCB>
}
    80002d0c:	00813083          	ld	ra,8(sp)
    80002d10:	00013403          	ld	s0,0(sp)
    80002d14:	01010113          	addi	sp,sp,16
    80002d18:	00008067          	ret

0000000080002d1c <_ZN3TCBD1Ev>:
TCB::~TCB() {
    80002d1c:	fe010113          	addi	sp,sp,-32
    80002d20:	00113c23          	sd	ra,24(sp)
    80002d24:	00813823          	sd	s0,16(sp)
    80002d28:	00913423          	sd	s1,8(sp)
    80002d2c:	02010413          	addi	s0,sp,32
    80002d30:	00050493          	mv	s1,a0
    delete[] stack;
    80002d34:	00853503          	ld	a0,8(a0)
    80002d38:	00050663          	beqz	a0,80002d44 <_ZN3TCBD1Ev+0x28>
    80002d3c:	fffff097          	auipc	ra,0xfffff
    80002d40:	184080e7          	jalr	388(ra) # 80001ec0 <_ZdaPv>
    delete[] kernelStack;
    80002d44:	0104b503          	ld	a0,16(s1)
    80002d48:	00050663          	beqz	a0,80002d54 <_ZN3TCBD1Ev+0x38>
    80002d4c:	fffff097          	auipc	ra,0xfffff
    80002d50:	174080e7          	jalr	372(ra) # 80001ec0 <_ZdaPv>
}
    80002d54:	01813083          	ld	ra,24(sp)
    80002d58:	01013403          	ld	s0,16(sp)
    80002d5c:	00813483          	ld	s1,8(sp)
    80002d60:	02010113          	addi	sp,sp,32
    80002d64:	00008067          	ret

0000000080002d68 <_ZN3TCB12createThreadEPFvPvEPmS3_S0_b>:
TCB * TCB::createThread(Body body, uint64* stack_space, uint64* kernel_stack_space, void* args, bool putInScheduler) {
    80002d68:	fc010113          	addi	sp,sp,-64
    80002d6c:	02113c23          	sd	ra,56(sp)
    80002d70:	02813823          	sd	s0,48(sp)
    80002d74:	02913423          	sd	s1,40(sp)
    80002d78:	03213023          	sd	s2,32(sp)
    80002d7c:	01313c23          	sd	s3,24(sp)
    80002d80:	01413823          	sd	s4,16(sp)
    80002d84:	01513423          	sd	s5,8(sp)
    80002d88:	01613023          	sd	s6,0(sp)
    80002d8c:	04010413          	addi	s0,sp,64
    80002d90:	00050913          	mv	s2,a0
    80002d94:	00058a13          	mv	s4,a1
    80002d98:	00060a93          	mv	s5,a2
    80002d9c:	00068993          	mv	s3,a3
    80002da0:	00070b13          	mv	s6,a4
     void* allocated = MemoryAllocator::malloc(size);
    80002da4:	00200513          	li	a0,2
    80002da8:	00001097          	auipc	ra,0x1
    80002dac:	af0080e7          	jalr	-1296(ra) # 80003898 <_ZN15MemoryAllocator6mallocEm>
    80002db0:	00050593          	mv	a1,a0
     return  new (allocated) TCB(body, args, stack_space,kernel_stack_space, DEFAULT_TIME_SLICE, putInScheduler);
    80002db4:	06000513          	li	a0,96
    80002db8:	00000097          	auipc	ra,0x0
    80002dbc:	e80080e7          	jalr	-384(ra) # 80002c38 <_ZN3TCBnwEmPv>
    80002dc0:	00050493          	mv	s1,a0
    80002dc4:	000b0813          	mv	a6,s6
    80002dc8:	00200793          	li	a5,2
    80002dcc:	000a8713          	mv	a4,s5
    80002dd0:	000a0693          	mv	a3,s4
    80002dd4:	00098613          	mv	a2,s3
    80002dd8:	00090593          	mv	a1,s2
    80002ddc:	00000097          	auipc	ra,0x0
    80002de0:	ea0080e7          	jalr	-352(ra) # 80002c7c <_ZN3TCBC1EPFvPvES0_PmS3_mb>
}
    80002de4:	00048513          	mv	a0,s1
    80002de8:	03813083          	ld	ra,56(sp)
    80002dec:	03013403          	ld	s0,48(sp)
    80002df0:	02813483          	ld	s1,40(sp)
    80002df4:	02013903          	ld	s2,32(sp)
    80002df8:	01813983          	ld	s3,24(sp)
    80002dfc:	01013a03          	ld	s4,16(sp)
    80002e00:	00813a83          	ld	s5,8(sp)
    80002e04:	00013b03          	ld	s6,0(sp)
    80002e08:	04010113          	addi	sp,sp,64
    80002e0c:	00008067          	ret

0000000080002e10 <_ZN3TCB5yieldEv>:
void TCB::yield() {
    80002e10:	ff010113          	addi	sp,sp,-16
    80002e14:	00813423          	sd	s0,8(sp)
    80002e18:	01010413          	addi	s0,sp,16
GENERATE_WRRD(a0);
    80002e1c:	01300793          	li	a5,19
    80002e20:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002e24:	00000073          	ecall
}
    80002e28:	00813403          	ld	s0,8(sp)
    80002e2c:	01010113          	addi	sp,sp,16
    80002e30:	00008067          	ret

0000000080002e34 <_ZN3TCB13threadWrapperEv>:
void TCB::threadWrapper() {
    80002e34:	fe010113          	addi	sp,sp,-32
    80002e38:	00113c23          	sd	ra,24(sp)
    80002e3c:	00813823          	sd	s0,16(sp)
    80002e40:	00913423          	sd	s1,8(sp)
    80002e44:	02010413          	addi	s0,sp,32
    RISCV::popSppSpie();
    80002e48:	00000097          	auipc	ra,0x0
    80002e4c:	b3c080e7          	jalr	-1220(ra) # 80002984 <_ZN5RISCV10popSppSpieEv>
    running -> body(running->args);
    80002e50:	0000a497          	auipc	s1,0xa
    80002e54:	ea048493          	addi	s1,s1,-352 # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
    80002e58:	0104b783          	ld	a5,16(s1)
    80002e5c:	0007b703          	ld	a4,0(a5)
    80002e60:	0207b503          	ld	a0,32(a5)
    80002e64:	000700e7          	jalr	a4
    running -> setFinished(true);
    80002e68:	0104b783          	ld	a5,16(s1)
        finished = value;
    80002e6c:	00100713          	li	a4,1
    80002e70:	02e78c23          	sb	a4,56(a5)
    }
    80002e74:	0240006f          	j	80002e98 <_ZN3TCB13threadWrapperEv+0x64>
        if (!head) { tail = 0; }
    80002e78:	0407b823          	sd	zero,80(a5)
        T *ret = elem->data;
    80002e7c:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    80002e80:	00001097          	auipc	ra,0x1
    80002e84:	b08080e7          	jalr	-1272(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
        if(!temp ) break;
    80002e88:	02048863          	beqz	s1,80002eb8 <_ZN3TCB13threadWrapperEv+0x84>
        Scheduler::put(temp);
    80002e8c:	00048513          	mv	a0,s1
    80002e90:	fffff097          	auipc	ra,0xfffff
    80002e94:	b04080e7          	jalr	-1276(ra) # 80001994 <_ZN9Scheduler3putEP3TCB>
        TCB* temp  = running -> awaitingThreads.removeFirst();
    80002e98:	0000a797          	auipc	a5,0xa
    80002e9c:	e687b783          	ld	a5,-408(a5) # 8000cd00 <_ZN3TCB7runningE>
        if (!head) { return 0; }
    80002ea0:	0487b503          	ld	a0,72(a5)
    80002ea4:	00050a63          	beqz	a0,80002eb8 <_ZN3TCB13threadWrapperEv+0x84>
        head = head->next;
    80002ea8:	00853703          	ld	a4,8(a0)
    80002eac:	04e7b423          	sd	a4,72(a5)
        if (!head) { tail = 0; }
    80002eb0:	fc0716e3          	bnez	a4,80002e7c <_ZN3TCB13threadWrapperEv+0x48>
    80002eb4:	fc5ff06f          	j	80002e78 <_ZN3TCB13threadWrapperEv+0x44>
    TCB::yield();
    80002eb8:	00000097          	auipc	ra,0x0
    80002ebc:	f58080e7          	jalr	-168(ra) # 80002e10 <_ZN3TCB5yieldEv>
}
    80002ec0:	01813083          	ld	ra,24(sp)
    80002ec4:	01013403          	ld	s0,16(sp)
    80002ec8:	00813483          	ld	s1,8(sp)
    80002ecc:	02010113          	addi	sp,sp,32
    80002ed0:	00008067          	ret

0000000080002ed4 <_ZN3TCB8dispatchEbP4_sem>:
void TCB::dispatch(bool putInScheduler, _sem* lockedSem) {
    80002ed4:	fe010113          	addi	sp,sp,-32
    80002ed8:	00113c23          	sd	ra,24(sp)
    80002edc:	00813823          	sd	s0,16(sp)
    80002ee0:	00913423          	sd	s1,8(sp)
    80002ee4:	01213023          	sd	s2,0(sp)
    80002ee8:	02010413          	addi	s0,sp,32
    80002eec:	00050913          	mv	s2,a0
    if(lockedSem) lockedSem->unlock();
    80002ef0:	00058863          	beqz	a1,80002f00 <_ZN3TCB8dispatchEbP4_sem+0x2c>
    80002ef4:	00058513          	mv	a0,a1
    80002ef8:	00000097          	auipc	ra,0x0
    80002efc:	4a4080e7          	jalr	1188(ra) # 8000339c <_ZN4_sem6unlockEv>
    TCB * old = running;
    80002f00:	0000a497          	auipc	s1,0xa
    80002f04:	e004b483          	ld	s1,-512(s1) # 8000cd00 <_ZN3TCB7runningE>
        return finished;
    80002f08:	0384c783          	lbu	a5,56(s1)
    if (!old -> isFinished() && putInScheduler && old->scheduled) {
    80002f0c:	00079863          	bnez	a5,80002f1c <_ZN3TCB8dispatchEbP4_sem+0x48>
    80002f10:	00090663          	beqz	s2,80002f1c <_ZN3TCB8dispatchEbP4_sem+0x48>
    80002f14:	05a4c783          	lbu	a5,90(s1)
    80002f18:	04079063          	bnez	a5,80002f58 <_ZN3TCB8dispatchEbP4_sem+0x84>
    running = Scheduler::get();
    80002f1c:	fffff097          	auipc	ra,0xfffff
    80002f20:	a08080e7          	jalr	-1528(ra) # 80001924 <_ZN9Scheduler3getEv>
    80002f24:	0000a797          	auipc	a5,0xa
    80002f28:	dca7be23          	sd	a0,-548(a5) # 8000cd00 <_ZN3TCB7runningE>
    if(old !=running) {
    80002f2c:	00a48a63          	beq	s1,a0,80002f40 <_ZN3TCB8dispatchEbP4_sem+0x6c>
        TCB::contextSwitch(&old->context, &running->context);
    80002f30:	01850593          	addi	a1,a0,24
    80002f34:	01848513          	addi	a0,s1,24
    80002f38:	ffffe097          	auipc	ra,0xffffe
    80002f3c:	5f0080e7          	jalr	1520(ra) # 80001528 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002f40:	01813083          	ld	ra,24(sp)
    80002f44:	01013403          	ld	s0,16(sp)
    80002f48:	00813483          	ld	s1,8(sp)
    80002f4c:	00013903          	ld	s2,0(sp)
    80002f50:	02010113          	addi	sp,sp,32
    80002f54:	00008067          	ret
        Scheduler::put(old);
    80002f58:	00048513          	mv	a0,s1
    80002f5c:	fffff097          	auipc	ra,0xfffff
    80002f60:	a38080e7          	jalr	-1480(ra) # 80001994 <_ZN9Scheduler3putEP3TCB>
    80002f64:	fb9ff06f          	j	80002f1c <_ZN3TCB8dispatchEbP4_sem+0x48>

0000000080002f68 <_ZN3TCB11getAwaitingEv>:
{
    80002f68:	fe010113          	addi	sp,sp,-32
    80002f6c:	00113c23          	sd	ra,24(sp)
    80002f70:	00813823          	sd	s0,16(sp)
    80002f74:	00913423          	sd	s1,8(sp)
    80002f78:	02010413          	addi	s0,sp,32
    80002f7c:	00050793          	mv	a5,a0
        if (!head) { return 0; }
    80002f80:	04853503          	ld	a0,72(a0)
    80002f84:	02050e63          	beqz	a0,80002fc0 <_ZN3TCB11getAwaitingEv+0x58>
        head = head->next;
    80002f88:	00853703          	ld	a4,8(a0)
    80002f8c:	04e7b423          	sd	a4,72(a5)
        if (!head) { tail = 0; }
    80002f90:	02070463          	beqz	a4,80002fb8 <_ZN3TCB11getAwaitingEv+0x50>
        T *ret = elem->data;
    80002f94:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    80002f98:	00001097          	auipc	ra,0x1
    80002f9c:	9f0080e7          	jalr	-1552(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
}
    80002fa0:	00048513          	mv	a0,s1
    80002fa4:	01813083          	ld	ra,24(sp)
    80002fa8:	01013403          	ld	s0,16(sp)
    80002fac:	00813483          	ld	s1,8(sp)
    80002fb0:	02010113          	addi	sp,sp,32
    80002fb4:	00008067          	ret
        if (!head) { tail = 0; }
    80002fb8:	0407b823          	sd	zero,80(a5)
    80002fbc:	fd9ff06f          	j	80002f94 <_ZN3TCB11getAwaitingEv+0x2c>
        if (!head) { return 0; }
    80002fc0:	00050493          	mv	s1,a0
    return awaitingThreads.removeFirst();
    80002fc4:	fddff06f          	j	80002fa0 <_ZN3TCB11getAwaitingEv+0x38>

0000000080002fc8 <_ZN3TCB11putAwaitingEPS_>:
{
    80002fc8:	fe010113          	addi	sp,sp,-32
    80002fcc:	00113c23          	sd	ra,24(sp)
    80002fd0:	00813823          	sd	s0,16(sp)
    80002fd4:	00913423          	sd	s1,8(sp)
    80002fd8:	01213023          	sd	s2,0(sp)
    80002fdc:	02010413          	addi	s0,sp,32
    80002fe0:	00050493          	mv	s1,a0
    80002fe4:	00058913          	mv	s2,a1
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
    80002fe8:	01000513          	li	a0,16
    80002fec:	00001097          	auipc	ra,0x1
    80002ff0:	95c080e7          	jalr	-1700(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002ff4:	01253023          	sd	s2,0(a0)
    80002ff8:	00053423          	sd	zero,8(a0)
        if (tail)
    80002ffc:	0504b783          	ld	a5,80(s1)
    80003000:	02078263          	beqz	a5,80003024 <_ZN3TCB11putAwaitingEPS_+0x5c>
            tail->next = elem;
    80003004:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80003008:	04a4b823          	sd	a0,80(s1)
}
    8000300c:	01813083          	ld	ra,24(sp)
    80003010:	01013403          	ld	s0,16(sp)
    80003014:	00813483          	ld	s1,8(sp)
    80003018:	00013903          	ld	s2,0(sp)
    8000301c:	02010113          	addi	sp,sp,32
    80003020:	00008067          	ret
            head = tail = elem;
    80003024:	04a4b823          	sd	a0,80(s1)
    80003028:	04a4b423          	sd	a0,72(s1)
    8000302c:	fe1ff06f          	j	8000300c <_ZN3TCB11putAwaitingEPS_+0x44>

0000000080003030 <_ZN3TCB5sleepEm>:
    if(time>0){
    80003030:	00051663          	bnez	a0,8000303c <_ZN3TCB5sleepEm+0xc>
}
    80003034:	00000513          	li	a0,0
    80003038:	00008067          	ret
int TCB::sleep(size_t time){
    8000303c:	fe010113          	addi	sp,sp,-32
    80003040:	00113c23          	sd	ra,24(sp)
    80003044:	00813823          	sd	s0,16(sp)
    80003048:	00913423          	sd	s1,8(sp)
    8000304c:	01213023          	sd	s2,0(sp)
    80003050:	02010413          	addi	s0,sp,32
        TCB::running->sleepTime=time;
    80003054:	0000a917          	auipc	s2,0xa
    80003058:	c9c90913          	addi	s2,s2,-868 # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
    8000305c:	01093483          	ld	s1,16(s2)
    80003060:	04a4b023          	sd	a0,64(s1)
        if (!tail) { return 0; }
        return tail->data;
    }

    void addInOrder(T *data){
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
    80003064:	01000513          	li	a0,16
    80003068:	00001097          	auipc	ra,0x1
    8000306c:	8e0080e7          	jalr	-1824(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80003070:	00953023          	sd	s1,0(a0)
    80003074:	00053423          	sd	zero,8(a0)
        Elem *elem = new (allocated) Elem(data, 0);

        Elem* prev = 0;
        Elem* current  = head;
    80003078:	00093783          	ld	a5,0(s2)
        return sleepTime;
    8000307c:	0404b583          	ld	a1,64(s1)

        size_t actualSleepTime = data->getSleepTime();
        size_t sum = 0;
    80003080:	00000693          	li	a3,0
        Elem* prev = 0;
    80003084:	00000613          	li	a2,0

        while(current){
    80003088:	02078263          	beqz	a5,800030ac <_ZN3TCB5sleepEm+0x7c>
            sum += current->data->getSleepTime();
    8000308c:	0007b703          	ld	a4,0(a5)
    80003090:	04073703          	ld	a4,64(a4)
    80003094:	00d70733          	add	a4,a4,a3
            if(sum>=actualSleepTime) {
    80003098:	00b77a63          	bgeu	a4,a1,800030ac <_ZN3TCB5sleepEm+0x7c>
            sum += current->data->getSleepTime();
    8000309c:	00070693          	mv	a3,a4
                sum -= current->data->getSleepTime();
                break;
            }
            prev = current;
    800030a0:	00078613          	mv	a2,a5
            current = current->next;
    800030a4:	0087b783          	ld	a5,8(a5)
        while(current){
    800030a8:	fe1ff06f          	j	80003088 <_ZN3TCB5sleepEm+0x58>
        }

        if(prev==0){
    800030ac:	04060c63          	beqz	a2,80003104 <_ZN3TCB5sleepEm+0xd4>
            elem->next = current;
            head = elem;
            if(elem->next) elem->next->data->setSleepTime(elem->next->data->getSleepTime()-actualSleepTime);
        }else{
            size_t relativeSleepTime = actualSleepTime - sum;
    800030b0:	40d58733          	sub	a4,a1,a3
        sleepTime=time;
    800030b4:	04e4b023          	sd	a4,64(s1)
            elem->data->setSleepTime(relativeSleepTime);
            prev->next = elem;
    800030b8:	00a63423          	sd	a0,8(a2)
            elem->next = current;
    800030bc:	00f53423          	sd	a5,8(a0)
            if(elem->next==0) tail = elem;
    800030c0:	06078463          	beqz	a5,80003128 <_ZN3TCB5sleepEm+0xf8>
            else{
                elem->next->data->setSleepTime(elem->next->data->getSleepTime()-relativeSleepTime);
    800030c4:	0007b783          	ld	a5,0(a5)
        return sleepTime;
    800030c8:	0407b703          	ld	a4,64(a5)
    800030cc:	40b686b3          	sub	a3,a3,a1
    800030d0:	00e686b3          	add	a3,a3,a4
        sleepTime=time;
    800030d4:	04d7b023          	sd	a3,64(a5)
        TCB::dispatch(false);
    800030d8:	00000593          	li	a1,0
    800030dc:	00000513          	li	a0,0
    800030e0:	00000097          	auipc	ra,0x0
    800030e4:	df4080e7          	jalr	-524(ra) # 80002ed4 <_ZN3TCB8dispatchEbP4_sem>
}
    800030e8:	00000513          	li	a0,0
    800030ec:	01813083          	ld	ra,24(sp)
    800030f0:	01013403          	ld	s0,16(sp)
    800030f4:	00813483          	ld	s1,8(sp)
    800030f8:	00013903          	ld	s2,0(sp)
    800030fc:	02010113          	addi	sp,sp,32
    80003100:	00008067          	ret
            elem->next = current;
    80003104:	00f53423          	sd	a5,8(a0)
            head = elem;
    80003108:	0000a717          	auipc	a4,0xa
    8000310c:	bea73423          	sd	a0,-1048(a4) # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
            if(elem->next) elem->next->data->setSleepTime(elem->next->data->getSleepTime()-actualSleepTime);
    80003110:	fc0784e3          	beqz	a5,800030d8 <_ZN3TCB5sleepEm+0xa8>
    80003114:	0007b783          	ld	a5,0(a5)
        return sleepTime;
    80003118:	0407b683          	ld	a3,64(a5)
    8000311c:	40b686b3          	sub	a3,a3,a1
        sleepTime=time;
    80003120:	04d7b023          	sd	a3,64(a5)
    }
    80003124:	fb5ff06f          	j	800030d8 <_ZN3TCB5sleepEm+0xa8>
            if(elem->next==0) tail = elem;
    80003128:	0000a797          	auipc	a5,0xa
    8000312c:	bca7b823          	sd	a0,-1072(a5) # 8000ccf8 <_ZN3TCB15sleepingThreadsE+0x8>
    80003130:	fa9ff06f          	j	800030d8 <_ZN3TCB5sleepEm+0xa8>

0000000080003134 <_ZN3TCB11wakeThreadsEv>:
        if (!head) { return 0; }
    80003134:	0000a517          	auipc	a0,0xa
    80003138:	bbc53503          	ld	a0,-1092(a0) # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
    8000313c:	0c050863          	beqz	a0,8000320c <_ZN3TCB11wakeThreadsEv+0xd8>
        return head->data;
    80003140:	00053703          	ld	a4,0(a0)
    if(sleeping){
    80003144:	0c070463          	beqz	a4,8000320c <_ZN3TCB11wakeThreadsEv+0xd8>
        sleepTime--;
    80003148:	04073783          	ld	a5,64(a4)
    8000314c:	fff78793          	addi	a5,a5,-1
    80003150:	04f73023          	sd	a5,64(a4)
        if(sleeping->getSleepTime()==0){
    80003154:	0a079c63          	bnez	a5,8000320c <_ZN3TCB11wakeThreadsEv+0xd8>
void TCB::wakeThreads(){
    80003158:	fe010113          	addi	sp,sp,-32
    8000315c:	00113c23          	sd	ra,24(sp)
    80003160:	00813823          	sd	s0,16(sp)
    80003164:	00913423          	sd	s1,8(sp)
    80003168:	02010413          	addi	s0,sp,32
        head = head->next;
    8000316c:	00853783          	ld	a5,8(a0)
    80003170:	0000a717          	auipc	a4,0xa
    80003174:	b8f73023          	sd	a5,-1152(a4) # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
        if (!head) { tail = 0; }
    80003178:	00078a63          	beqz	a5,8000318c <_ZN3TCB11wakeThreadsEv+0x58>
        T *ret = elem->data;
    8000317c:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    80003180:	00001097          	auipc	ra,0x1
    80003184:	808080e7          	jalr	-2040(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
    80003188:	0340006f          	j	800031bc <_ZN3TCB11wakeThreadsEv+0x88>
        if (!head) { tail = 0; }
    8000318c:	0000a797          	auipc	a5,0xa
    80003190:	b607b623          	sd	zero,-1172(a5) # 8000ccf8 <_ZN3TCB15sleepingThreadsE+0x8>
    80003194:	fe9ff06f          	j	8000317c <_ZN3TCB11wakeThreadsEv+0x48>
                if(temp->isFinished()==false) Scheduler::put(temp);
    80003198:	00048513          	mv	a0,s1
    8000319c:	ffffe097          	auipc	ra,0xffffe
    800031a0:	7f8080e7          	jalr	2040(ra) # 80001994 <_ZN9Scheduler3putEP3TCB>
    800031a4:	0240006f          	j	800031c8 <_ZN3TCB11wakeThreadsEv+0x94>
    800031a8:	0000a797          	auipc	a5,0xa
    800031ac:	b407b823          	sd	zero,-1200(a5) # 8000ccf8 <_ZN3TCB15sleepingThreadsE+0x8>
        T *ret = elem->data;
    800031b0:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	7d4080e7          	jalr	2004(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
            while(temp){
    800031bc:	02048e63          	beqz	s1,800031f8 <_ZN3TCB11wakeThreadsEv+0xc4>
        return finished;
    800031c0:	0384c783          	lbu	a5,56(s1)
                if(temp->isFinished()==false) Scheduler::put(temp);
    800031c4:	fc078ae3          	beqz	a5,80003198 <_ZN3TCB11wakeThreadsEv+0x64>
        if (!head) { return 0; }
    800031c8:	0000a517          	auipc	a0,0xa
    800031cc:	b2853503          	ld	a0,-1240(a0) # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
    800031d0:	02050463          	beqz	a0,800031f8 <_ZN3TCB11wakeThreadsEv+0xc4>
        return head->data;
    800031d4:	00053783          	ld	a5,0(a0)
                if(!temp || temp->getSleepTime()!=0) break;
    800031d8:	02078063          	beqz	a5,800031f8 <_ZN3TCB11wakeThreadsEv+0xc4>
        return sleepTime;
    800031dc:	0407b783          	ld	a5,64(a5)
    800031e0:	00079c63          	bnez	a5,800031f8 <_ZN3TCB11wakeThreadsEv+0xc4>
        head = head->next;
    800031e4:	00853783          	ld	a5,8(a0)
    800031e8:	0000a717          	auipc	a4,0xa
    800031ec:	b0f73423          	sd	a5,-1272(a4) # 8000ccf0 <_ZN3TCB15sleepingThreadsE>
        if (!head) { tail = 0; }
    800031f0:	fc0790e3          	bnez	a5,800031b0 <_ZN3TCB11wakeThreadsEv+0x7c>
    800031f4:	fb5ff06f          	j	800031a8 <_ZN3TCB11wakeThreadsEv+0x74>
}
    800031f8:	01813083          	ld	ra,24(sp)
    800031fc:	01013403          	ld	s0,16(sp)
    80003200:	00813483          	ld	s1,8(sp)
    80003204:	02010113          	addi	sp,sp,32
    80003208:	00008067          	ret
    8000320c:	00008067          	ret

0000000080003210 <_ZN3TCB10idleThreadEPv>:
void TCB::idleThread(void *arg) {
    80003210:	ff010113          	addi	sp,sp,-16
    80003214:	00813423          	sd	s0,8(sp)
    80003218:	01010413          	addi	s0,sp,16
    while(true){
    8000321c:	0000006f          	j	8000321c <_ZN3TCB10idleThreadEPv+0xc>

0000000080003220 <_ZN3TCB18consoleWriteThreadEPv>:
        while((*((char*)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT)){
    80003220:	0000a797          	auipc	a5,0xa
    80003224:	9e07b783          	ld	a5,-1568(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003228:	0007b783          	ld	a5,0(a5)
    8000322c:	0007c783          	lbu	a5,0(a5)
    80003230:	0207f793          	andi	a5,a5,32
    80003234:	fe0786e3          	beqz	a5,80003220 <_ZN3TCB18consoleWriteThreadEPv>
void TCB::consoleWriteThread(void *arg) {
    80003238:	fe010113          	addi	sp,sp,-32
    8000323c:	00113c23          	sd	ra,24(sp)
    80003240:	00813823          	sd	s0,16(sp)
    80003244:	00913423          	sd	s1,8(sp)
    80003248:	01213023          	sd	s2,0(sp)
    8000324c:	02010413          	addi	s0,sp,32
            char c = outputBuffer->receiveSys();
    80003250:	0000a797          	auipc	a5,0xa
    80003254:	9a87b783          	ld	a5,-1624(a5) # 8000cbf8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003258:	0007b483          	ld	s1,0(a5)
        sem_wait(mutex);
    8000325c:	0184b503          	ld	a0,24(s1)
    80003260:	ffffe097          	auipc	ra,0xffffe
    80003264:	558080e7          	jalr	1368(ra) # 800017b8 <_Z8sem_waitP4_sem>
        if (front == -1) return true;
    80003268:	0104a703          	lw	a4,16(s1)
    8000326c:	fff00793          	li	a5,-1
    80003270:	06f70e63          	beq	a4,a5,800032ec <_ZN3TCB18consoleWriteThreadEPv+0xcc>
        if (front == -1){
            // ???
            return buffer[0];
        }

        int data = buffer[front];
    80003274:	0004b783          	ld	a5,0(s1)
    80003278:	00e787b3          	add	a5,a5,a4
    8000327c:	0007c903          	lbu	s2,0(a5)
        buffer[front] = -1;
    80003280:	fff00713          	li	a4,-1
    80003284:	00e78023          	sb	a4,0(a5)

        if (front == rear)
    80003288:	0104a783          	lw	a5,16(s1)
    8000328c:	00c4a703          	lw	a4,12(s1)
    80003290:	08e78263          	beq	a5,a4,80003314 <_ZN3TCB18consoleWriteThreadEPv+0xf4>
        {
            front = -1;
            rear = -1;
        }

        else if (front == size - 1)
    80003294:	0084a703          	lw	a4,8(s1)
    80003298:	fff7071b          	addiw	a4,a4,-1
    8000329c:	08e78463          	beq	a5,a4,80003324 <_ZN3TCB18consoleWriteThreadEPv+0x104>
            front = 0;

        else
            front++;
    800032a0:	0017879b          	addiw	a5,a5,1
    800032a4:	00f4a823          	sw	a5,16(s1)
        if (notFull->value()<0) sem_signal(notFull);
    800032a8:	0284b503          	ld	a0,40(s1)
        void lock();
        void unlock();
        int wait();
        int signal();
        int value(){
            return val;
    800032ac:	00052783          	lw	a5,0(a0)
    800032b0:	0607ce63          	bltz	a5,8000332c <_ZN3TCB18consoleWriteThreadEPv+0x10c>
        sem_signal(mutex);
    800032b4:	0184b503          	ld	a0,24(s1)
    800032b8:	ffffe097          	auipc	ra,0xffffe
    800032bc:	538080e7          	jalr	1336(ra) # 800017f0 <_Z10sem_signalP4_sem>
            *((char*)CONSOLE_TX_DATA) = c;
    800032c0:	0000a797          	auipc	a5,0xa
    800032c4:	9607b783          	ld	a5,-1696(a5) # 8000cc20 <_GLOBAL_OFFSET_TABLE_+0x30>
    800032c8:	0007b783          	ld	a5,0(a5)
    800032cc:	01278023          	sb	s2,0(a5)
        while((*((char*)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT)){
    800032d0:	0000a797          	auipc	a5,0xa
    800032d4:	9307b783          	ld	a5,-1744(a5) # 8000cc00 <_GLOBAL_OFFSET_TABLE_+0x10>
    800032d8:	0007b783          	ld	a5,0(a5)
    800032dc:	0007c783          	lbu	a5,0(a5)
    800032e0:	0207f793          	andi	a5,a5,32
    800032e4:	fe0786e3          	beqz	a5,800032d0 <_ZN3TCB18consoleWriteThreadEPv+0xb0>
    800032e8:	f69ff06f          	j	80003250 <_ZN3TCB18consoleWriteThreadEPv+0x30>
            sem_signal(mutex);
    800032ec:	0184b503          	ld	a0,24(s1)
    800032f0:	ffffe097          	auipc	ra,0xffffe
    800032f4:	500080e7          	jalr	1280(ra) # 800017f0 <_Z10sem_signalP4_sem>
            sem_wait(notEmpty);
    800032f8:	0204b503          	ld	a0,32(s1)
    800032fc:	ffffe097          	auipc	ra,0xffffe
    80003300:	4bc080e7          	jalr	1212(ra) # 800017b8 <_Z8sem_waitP4_sem>
            sem_wait(mutex);
    80003304:	0184b503          	ld	a0,24(s1)
    80003308:	ffffe097          	auipc	ra,0xffffe
    8000330c:	4b0080e7          	jalr	1200(ra) # 800017b8 <_Z8sem_waitP4_sem>
        while (isEmpty()) {
    80003310:	f59ff06f          	j	80003268 <_ZN3TCB18consoleWriteThreadEPv+0x48>
            front = -1;
    80003314:	fff00793          	li	a5,-1
    80003318:	00f4a823          	sw	a5,16(s1)
            rear = -1;
    8000331c:	00f4a623          	sw	a5,12(s1)
    80003320:	f89ff06f          	j	800032a8 <_ZN3TCB18consoleWriteThreadEPv+0x88>
            front = 0;
    80003324:	0004a823          	sw	zero,16(s1)
    80003328:	f81ff06f          	j	800032a8 <_ZN3TCB18consoleWriteThreadEPv+0x88>
        if (notFull->value()<0) sem_signal(notFull);
    8000332c:	ffffe097          	auipc	ra,0xffffe
    80003330:	4c4080e7          	jalr	1220(ra) # 800017f0 <_Z10sem_signalP4_sem>
    80003334:	f81ff06f          	j	800032b4 <_ZN3TCB18consoleWriteThreadEPv+0x94>

0000000080003338 <_GLOBAL__sub_I__ZN3TCB7runningE>:
}
    80003338:	ff010113          	addi	sp,sp,-16
    8000333c:	00113423          	sd	ra,8(sp)
    80003340:	00813023          	sd	s0,0(sp)
    80003344:	01010413          	addi	s0,sp,16
    80003348:	000105b7          	lui	a1,0x10
    8000334c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80003350:	00100513          	li	a0,1
    80003354:	00000097          	auipc	ra,0x0
    80003358:	8a4080e7          	jalr	-1884(ra) # 80002bf8 <_Z41__static_initialization_and_destruction_0ii>
    8000335c:	00813083          	ld	ra,8(sp)
    80003360:	00013403          	ld	s0,0(sp)
    80003364:	01010113          	addi	sp,sp,16
    80003368:	00008067          	ret

000000008000336c <_ZN4_sem4lockEv>:
#include "../h/_sem.hpp"

void _sem::lock(){
    8000336c:	ff010113          	addi	sp,sp,-16
    80003370:	00813423          	sd	s0,8(sp)
    80003374:	01010413          	addi	s0,sp,16
    register uint64 swapWith = 1;
    80003378:	00100793          	li	a5,1
    while(swapWith==1) {
    8000337c:	00100713          	li	a4,1
    80003380:	00e79863          	bne	a5,a4,80003390 <_ZN4_sem4lockEv+0x24>
        __asm__ volatile("amoswap.d.aq %[reg], %[rs2], %[rs1]"
                :[reg] "=r"(swapWith), [rs1] "+A"(this->lck)
        :[rs2] "r"(swapWith));
    80003384:	00850713          	addi	a4,a0,8
    80003388:	0cf737af          	amoswap.d.aq	a5,a5,(a4)
    while(swapWith==1) {
    8000338c:	ff1ff06f          	j	8000337c <_ZN4_sem4lockEv+0x10>
    }
}
    80003390:	00813403          	ld	s0,8(sp)
    80003394:	01010113          	addi	sp,sp,16
    80003398:	00008067          	ret

000000008000339c <_ZN4_sem6unlockEv>:
void _sem::unlock(){
    8000339c:	ff010113          	addi	sp,sp,-16
    800033a0:	00813423          	sd	s0,8(sp)
    800033a4:	01010413          	addi	s0,sp,16
    lck = 0;
    800033a8:	00053423          	sd	zero,8(a0)
}
    800033ac:	00813403          	ld	s0,8(sp)
    800033b0:	01010113          	addi	sp,sp,16
    800033b4:	00008067          	ret

00000000800033b8 <_ZN4_sem5blockEv>:
    if(++val<=0) return_code = unblock();
    _sem::unlock();
    return return_code;
}

int _sem::block() {
    800033b8:	fe010113          	addi	sp,sp,-32
    800033bc:	00113c23          	sd	ra,24(sp)
    800033c0:	00813823          	sd	s0,16(sp)
    800033c4:	00913423          	sd	s1,8(sp)
    800033c8:	01213023          	sd	s2,0(sp)
    800033cc:	02010413          	addi	s0,sp,32
    800033d0:	00050493          	mv	s1,a0
    TCB* running = TCB::running;
    800033d4:	0000a797          	auipc	a5,0xa
    800033d8:	86c7b783          	ld	a5,-1940(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    800033dc:	0007b903          	ld	s2,0(a5)
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
    800033e0:	01000513          	li	a0,16
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	564080e7          	jalr	1380(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800033ec:	01253023          	sd	s2,0(a0)
    800033f0:	00053423          	sd	zero,8(a0)
        if (tail)
    800033f4:	0184b783          	ld	a5,24(s1)
    800033f8:	04078e63          	beqz	a5,80003454 <_ZN4_sem5blockEv+0x9c>
            tail->next = elem;
    800033fc:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80003400:	00a4bc23          	sd	a0,24(s1)
    blockedQueue.addLast(running);
    TCB::timeSliceCounter = 0;
    80003404:	0000a797          	auipc	a5,0xa
    80003408:	80c7b783          	ld	a5,-2036(a5) # 8000cc10 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000340c:	0007b023          	sd	zero,0(a5)
    TCB::dispatch(false, this);
    80003410:	00048593          	mv	a1,s1
    80003414:	00000513          	li	a0,0
    80003418:	00000097          	auipc	ra,0x0
    8000341c:	abc080e7          	jalr	-1348(ra) # 80002ed4 <_ZN3TCB8dispatchEbP4_sem>
    if(TCB::running->semaphoreDestroyed){
    80003420:	0000a797          	auipc	a5,0xa
    80003424:	8207b783          	ld	a5,-2016(a5) # 8000cc40 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003428:	0007b783          	ld	a5,0(a5)
    8000342c:	0587c703          	lbu	a4,88(a5)
    80003430:	02071863          	bnez	a4,80003460 <_ZN4_sem5blockEv+0xa8>
        semaphoreDestroyed = false;
    80003434:	04078c23          	sb	zero,88(a5)
        TCB::running->clearSemaphoreDestroyed();
        return -1;
    }else{
        TCB::running->clearSemaphoreDestroyed();
        return 0;
    80003438:	00000513          	li	a0,0
    }

}
    8000343c:	01813083          	ld	ra,24(sp)
    80003440:	01013403          	ld	s0,16(sp)
    80003444:	00813483          	ld	s1,8(sp)
    80003448:	00013903          	ld	s2,0(sp)
    8000344c:	02010113          	addi	sp,sp,32
    80003450:	00008067          	ret
            head = tail = elem;
    80003454:	00a4bc23          	sd	a0,24(s1)
    80003458:	00a4b823          	sd	a0,16(s1)
    8000345c:	fa9ff06f          	j	80003404 <_ZN4_sem5blockEv+0x4c>
    80003460:	04078c23          	sb	zero,88(a5)
        return -1;
    80003464:	fff00513          	li	a0,-1
    80003468:	fd5ff06f          	j	8000343c <_ZN4_sem5blockEv+0x84>

000000008000346c <_ZN4_sem4waitEv>:
int _sem::wait() {
    8000346c:	fe010113          	addi	sp,sp,-32
    80003470:	00113c23          	sd	ra,24(sp)
    80003474:	00813823          	sd	s0,16(sp)
    80003478:	00913423          	sd	s1,8(sp)
    8000347c:	01213023          	sd	s2,0(sp)
    80003480:	02010413          	addi	s0,sp,32
    80003484:	00050493          	mv	s1,a0
    _sem::lock();
    80003488:	00000097          	auipc	ra,0x0
    8000348c:	ee4080e7          	jalr	-284(ra) # 8000336c <_ZN4_sem4lockEv>
    if(--val<0) return_code = block();
    80003490:	0004a783          	lw	a5,0(s1)
    80003494:	fff7879b          	addiw	a5,a5,-1
    80003498:	00f4a023          	sw	a5,0(s1)
    8000349c:	02079713          	slli	a4,a5,0x20
    800034a0:	02074863          	bltz	a4,800034d0 <_ZN4_sem4waitEv+0x64>
    int return_code = 0 ;
    800034a4:	00000913          	li	s2,0
    _sem::unlock();
    800034a8:	00048513          	mv	a0,s1
    800034ac:	00000097          	auipc	ra,0x0
    800034b0:	ef0080e7          	jalr	-272(ra) # 8000339c <_ZN4_sem6unlockEv>
}
    800034b4:	00090513          	mv	a0,s2
    800034b8:	01813083          	ld	ra,24(sp)
    800034bc:	01013403          	ld	s0,16(sp)
    800034c0:	00813483          	ld	s1,8(sp)
    800034c4:	00013903          	ld	s2,0(sp)
    800034c8:	02010113          	addi	sp,sp,32
    800034cc:	00008067          	ret
    if(--val<0) return_code = block();
    800034d0:	00048513          	mv	a0,s1
    800034d4:	00000097          	auipc	ra,0x0
    800034d8:	ee4080e7          	jalr	-284(ra) # 800033b8 <_ZN4_sem5blockEv>
    800034dc:	00050913          	mv	s2,a0
    800034e0:	fc9ff06f          	j	800034a8 <_ZN4_sem4waitEv+0x3c>

00000000800034e4 <_ZN4_sem7unblockEv>:

int _sem::unblock() {
    800034e4:	00050793          	mv	a5,a0
        if (!head) { return 0; }
    800034e8:	01053503          	ld	a0,16(a0)
    800034ec:	06050063          	beqz	a0,8000354c <_ZN4_sem7unblockEv+0x68>
    800034f0:	fe010113          	addi	sp,sp,-32
    800034f4:	00113c23          	sd	ra,24(sp)
    800034f8:	00813823          	sd	s0,16(sp)
    800034fc:	00913423          	sd	s1,8(sp)
    80003500:	02010413          	addi	s0,sp,32
        head = head->next;
    80003504:	00853703          	ld	a4,8(a0)
    80003508:	00e7b823          	sd	a4,16(a5)
        if (!head) { tail = 0; }
    8000350c:	02070c63          	beqz	a4,80003544 <_ZN4_sem7unblockEv+0x60>
        T *ret = elem->data;
    80003510:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    80003514:	00000097          	auipc	ra,0x0
    80003518:	474080e7          	jalr	1140(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
    TCB* blocked = blockedQueue.removeFirst();
    if(blocked){
    8000351c:	02048c63          	beqz	s1,80003554 <_ZN4_sem7unblockEv+0x70>
        Scheduler::put(blocked);
    80003520:	00048513          	mv	a0,s1
    80003524:	ffffe097          	auipc	ra,0xffffe
    80003528:	470080e7          	jalr	1136(ra) # 80001994 <_ZN9Scheduler3putEP3TCB>
        return 0;
    8000352c:	00000513          	li	a0,0
    }
    return -1;
}
    80003530:	01813083          	ld	ra,24(sp)
    80003534:	01013403          	ld	s0,16(sp)
    80003538:	00813483          	ld	s1,8(sp)
    8000353c:	02010113          	addi	sp,sp,32
    80003540:	00008067          	ret
        if (!head) { tail = 0; }
    80003544:	0007bc23          	sd	zero,24(a5)
    80003548:	fc9ff06f          	j	80003510 <_ZN4_sem7unblockEv+0x2c>
    return -1;
    8000354c:	fff00513          	li	a0,-1
}
    80003550:	00008067          	ret
    return -1;
    80003554:	fff00513          	li	a0,-1
    80003558:	fd9ff06f          	j	80003530 <_ZN4_sem7unblockEv+0x4c>

000000008000355c <_ZN4_sem6signalEv>:
int _sem::signal() {
    8000355c:	fe010113          	addi	sp,sp,-32
    80003560:	00113c23          	sd	ra,24(sp)
    80003564:	00813823          	sd	s0,16(sp)
    80003568:	00913423          	sd	s1,8(sp)
    8000356c:	01213023          	sd	s2,0(sp)
    80003570:	02010413          	addi	s0,sp,32
    80003574:	00050493          	mv	s1,a0
    _sem::lock();
    80003578:	00000097          	auipc	ra,0x0
    8000357c:	df4080e7          	jalr	-524(ra) # 8000336c <_ZN4_sem4lockEv>
    if(++val<=0) return_code = unblock();
    80003580:	0004a783          	lw	a5,0(s1)
    80003584:	0017879b          	addiw	a5,a5,1
    80003588:	0007871b          	sext.w	a4,a5
    8000358c:	00f4a023          	sw	a5,0(s1)
    80003590:	02e05863          	blez	a4,800035c0 <_ZN4_sem6signalEv+0x64>
    int return_code = 0 ;
    80003594:	00000913          	li	s2,0
    _sem::unlock();
    80003598:	00048513          	mv	a0,s1
    8000359c:	00000097          	auipc	ra,0x0
    800035a0:	e00080e7          	jalr	-512(ra) # 8000339c <_ZN4_sem6unlockEv>
}
    800035a4:	00090513          	mv	a0,s2
    800035a8:	01813083          	ld	ra,24(sp)
    800035ac:	01013403          	ld	s0,16(sp)
    800035b0:	00813483          	ld	s1,8(sp)
    800035b4:	00013903          	ld	s2,0(sp)
    800035b8:	02010113          	addi	sp,sp,32
    800035bc:	00008067          	ret
    if(++val<=0) return_code = unblock();
    800035c0:	00048513          	mv	a0,s1
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	f20080e7          	jalr	-224(ra) # 800034e4 <_ZN4_sem7unblockEv>
    800035cc:	00050913          	mv	s2,a0
    800035d0:	fc9ff06f          	j	80003598 <_ZN4_sem6signalEv+0x3c>

00000000800035d4 <_ZN4_semnwEm>:

void* _sem::operator new(size_t size) {
    800035d4:	ff010113          	addi	sp,sp,-16
    800035d8:	00113423          	sd	ra,8(sp)
    800035dc:	00813023          	sd	s0,0(sp)
    800035e0:	01010413          	addi	s0,sp,16
    return MemoryAllocator::malloc_bytes(size);
    800035e4:	00000097          	auipc	ra,0x0
    800035e8:	364080e7          	jalr	868(ra) # 80003948 <_ZN15MemoryAllocator12malloc_bytesEm>
}
    800035ec:	00813083          	ld	ra,8(sp)
    800035f0:	00013403          	ld	s0,0(sp)
    800035f4:	01010113          	addi	sp,sp,16
    800035f8:	00008067          	ret

00000000800035fc <_ZN4_semnwEmPv>:
void* _sem::operator new(size_t size, void *memory) {
    800035fc:	ff010113          	addi	sp,sp,-16
    80003600:	00813423          	sd	s0,8(sp)
    80003604:	01010413          	addi	s0,sp,16
    return (_sem*) memory;
}
    80003608:	00058513          	mv	a0,a1
    8000360c:	00813403          	ld	s0,8(sp)
    80003610:	01010113          	addi	sp,sp,16
    80003614:	00008067          	ret

0000000080003618 <_ZN4_semdlEPv>:
void _sem::operator delete(void *memory) {
    80003618:	ff010113          	addi	sp,sp,-16
    8000361c:	00113423          	sd	ra,8(sp)
    80003620:	00813023          	sd	s0,0(sp)
    80003624:	01010413          	addi	s0,sp,16
    MemoryAllocator::free(memory);
    80003628:	00000097          	auipc	ra,0x0
    8000362c:	360080e7          	jalr	864(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
}
    80003630:	00813083          	ld	ra,8(sp)
    80003634:	00013403          	ld	s0,0(sp)
    80003638:	01010113          	addi	sp,sp,16
    8000363c:	00008067          	ret

0000000080003640 <_ZN4_semD1Ev>:

_sem::~_sem() {
    80003640:	fe010113          	addi	sp,sp,-32
    80003644:	00113c23          	sd	ra,24(sp)
    80003648:	00813823          	sd	s0,16(sp)
    8000364c:	00913423          	sd	s1,8(sp)
    80003650:	01213023          	sd	s2,0(sp)
    80003654:	02010413          	addi	s0,sp,32
    80003658:	00050913          	mv	s2,a0
    8000365c:	02c0006f          	j	80003688 <_ZN4_semD1Ev+0x48>
    80003660:	00093c23          	sd	zero,24(s2)
        T *ret = elem->data;
    80003664:	00053483          	ld	s1,0(a0)
            MemoryAllocator::free(ptr);
    80003668:	00000097          	auipc	ra,0x0
    8000366c:	320080e7          	jalr	800(ra) # 80003988 <_ZN15MemoryAllocator4freeEPv>
    while (TCB* temp = blockedQueue.removeFirst()) {
    80003670:	02048863          	beqz	s1,800036a0 <_ZN4_semD1Ev+0x60>
        semaphoreDestroyed = true;
    80003674:	00100793          	li	a5,1
    80003678:	04f48c23          	sb	a5,88(s1)
        temp->setSemaphoreDestroyed();
        Scheduler::put(temp);
    8000367c:	00048513          	mv	a0,s1
    80003680:	ffffe097          	auipc	ra,0xffffe
    80003684:	314080e7          	jalr	788(ra) # 80001994 <_ZN9Scheduler3putEP3TCB>
        if (!head) { return 0; }
    80003688:	01093503          	ld	a0,16(s2)
    8000368c:	00050a63          	beqz	a0,800036a0 <_ZN4_semD1Ev+0x60>
        head = head->next;
    80003690:	00853783          	ld	a5,8(a0)
    80003694:	00f93823          	sd	a5,16(s2)
        if (!head) { tail = 0; }
    80003698:	fc0796e3          	bnez	a5,80003664 <_ZN4_semD1Ev+0x24>
    8000369c:	fc5ff06f          	j	80003660 <_ZN4_semD1Ev+0x20>

    }
}
    800036a0:	01813083          	ld	ra,24(sp)
    800036a4:	01013403          	ld	s0,16(sp)
    800036a8:	00813483          	ld	s1,8(sp)
    800036ac:	00013903          	ld	s2,0(sp)
    800036b0:	02010113          	addi	sp,sp,32
    800036b4:	00008067          	ret

00000000800036b8 <_Z10signalWaitP4_semS0_>:


void signalWait (_sem* s, _sem* w){
    800036b8:	fe010113          	addi	sp,sp,-32
    800036bc:	00113c23          	sd	ra,24(sp)
    800036c0:	00813823          	sd	s0,16(sp)
    800036c4:	00913423          	sd	s1,8(sp)
    800036c8:	01213023          	sd	s2,0(sp)
    800036cc:	02010413          	addi	s0,sp,32
    800036d0:	00050913          	mv	s2,a0
    800036d4:	00058493          	mv	s1,a1
    s->lock();
    800036d8:	00000097          	auipc	ra,0x0
    800036dc:	c94080e7          	jalr	-876(ra) # 8000336c <_ZN4_sem4lockEv>
    if (s && s->val++<0) s->unblock();
    800036e0:	00090a63          	beqz	s2,800036f4 <_Z10signalWaitP4_semS0_+0x3c>
    800036e4:	00092783          	lw	a5,0(s2)
    800036e8:	0017871b          	addiw	a4,a5,1
    800036ec:	00e92023          	sw	a4,0(s2)
    800036f0:	0407cc63          	bltz	a5,80003748 <_Z10signalWaitP4_semS0_+0x90>
    s->unlock();
    800036f4:	00090513          	mv	a0,s2
    800036f8:	00000097          	auipc	ra,0x0
    800036fc:	ca4080e7          	jalr	-860(ra) # 8000339c <_ZN4_sem6unlockEv>
    w->lock();
    80003700:	00048513          	mv	a0,s1
    80003704:	00000097          	auipc	ra,0x0
    80003708:	c68080e7          	jalr	-920(ra) # 8000336c <_ZN4_sem4lockEv>
    if (w && --w->val<0) w->block();
    8000370c:	00048c63          	beqz	s1,80003724 <_Z10signalWaitP4_semS0_+0x6c>
    80003710:	0004a783          	lw	a5,0(s1)
    80003714:	fff7879b          	addiw	a5,a5,-1
    80003718:	00f4a023          	sw	a5,0(s1)
    8000371c:	02079713          	slli	a4,a5,0x20
    80003720:	02074c63          	bltz	a4,80003758 <_Z10signalWaitP4_semS0_+0xa0>
    w->unlock();
    80003724:	00048513          	mv	a0,s1
    80003728:	00000097          	auipc	ra,0x0
    8000372c:	c74080e7          	jalr	-908(ra) # 8000339c <_ZN4_sem6unlockEv>
    80003730:	01813083          	ld	ra,24(sp)
    80003734:	01013403          	ld	s0,16(sp)
    80003738:	00813483          	ld	s1,8(sp)
    8000373c:	00013903          	ld	s2,0(sp)
    80003740:	02010113          	addi	sp,sp,32
    80003744:	00008067          	ret
    if (s && s->val++<0) s->unblock();
    80003748:	00090513          	mv	a0,s2
    8000374c:	00000097          	auipc	ra,0x0
    80003750:	d98080e7          	jalr	-616(ra) # 800034e4 <_ZN4_sem7unblockEv>
    80003754:	fa1ff06f          	j	800036f4 <_Z10signalWaitP4_semS0_+0x3c>
    if (w && --w->val<0) w->block();
    80003758:	00048513          	mv	a0,s1
    8000375c:	00000097          	auipc	ra,0x0
    80003760:	c5c080e7          	jalr	-932(ra) # 800033b8 <_ZN4_sem5blockEv>
    80003764:	fc1ff06f          	j	80003724 <_Z10signalWaitP4_semS0_+0x6c>

0000000080003768 <_ZN15MemoryAllocator4initEv>:

Block* MemoryAllocator::free_memory;
bool MemoryAllocator::initialized = false;
size_t MemoryAllocator::mem_block_offset = 0;

void MemoryAllocator::init(){
    80003768:	ff010113          	addi	sp,sp,-16
    8000376c:	00813423          	sd	s0,8(sp)
    80003770:	01010413          	addi	s0,sp,16

    // Finding offset of MEM_BLOCK_SIZE for shift operations.
    // For MEM_BLOCK_SIZE=64 offset is 5 (2^5=64)
    size_t i = MEM_BLOCK_SIZE;
    80003774:	04000713          	li	a4,64
    while (i >>= 1) {
    80003778:	00175713          	srli	a4,a4,0x1
    8000377c:	00070e63          	beqz	a4,80003798 <_ZN15MemoryAllocator4initEv+0x30>
        ++MemoryAllocator::mem_block_offset;
    80003780:	00009697          	auipc	a3,0x9
    80003784:	59068693          	addi	a3,a3,1424 # 8000cd10 <_ZN15MemoryAllocator16mem_block_offsetE>
    80003788:	0006b783          	ld	a5,0(a3)
    8000378c:	00178793          	addi	a5,a5,1
    80003790:	00f6b023          	sd	a5,0(a3)
    while (i >>= 1) {
    80003794:	fe5ff06f          	j	80003778 <_ZN15MemoryAllocator4initEv+0x10>
    }

    // Align heap forward if not aligned to MEM_BLOCK_SIZE
    uint64 aligned_heap_start;
    uint64 modulo = (uint64)HEAP_START_ADDR & ((uint64)MEM_BLOCK_SIZE-1);
    80003798:	00009797          	auipc	a5,0x9
    8000379c:	4707b783          	ld	a5,1136(a5) # 8000cc08 <_GLOBAL_OFFSET_TABLE_+0x18>
    800037a0:	0007b783          	ld	a5,0(a5)
    800037a4:	03f7f713          	andi	a4,a5,63
    aligned_heap_start = modulo==0x0? (uint64)HEAP_START_ADDR: (uint64)HEAP_START_ADDR+(uint64)MEM_BLOCK_SIZE-modulo;
    800037a8:	00070663          	beqz	a4,800037b4 <_ZN15MemoryAllocator4initEv+0x4c>
    800037ac:	40e787b3          	sub	a5,a5,a4
    800037b0:	04078793          	addi	a5,a5,64

    // List of free segment has only one free segment
    // with size of whole available heap
    MemoryAllocator::free_memory = (Block*) aligned_heap_start;
    800037b4:	00009697          	auipc	a3,0x9
    800037b8:	55c68693          	addi	a3,a3,1372 # 8000cd10 <_ZN15MemoryAllocator16mem_block_offsetE>
    800037bc:	00f6b423          	sd	a5,8(a3)
    MemoryAllocator::free_memory->size = ((uint64)HEAP_END_ADDR - aligned_heap_start)/(uint64)MEM_BLOCK_SIZE;
    800037c0:	00009717          	auipc	a4,0x9
    800037c4:	48873703          	ld	a4,1160(a4) # 8000cc48 <_GLOBAL_OFFSET_TABLE_+0x58>
    800037c8:	00073703          	ld	a4,0(a4)
    800037cc:	40f70733          	sub	a4,a4,a5
    800037d0:	00675713          	srli	a4,a4,0x6
    800037d4:	00e7b023          	sd	a4,0(a5)
    MemoryAllocator::free_memory->next = nullptr;
    800037d8:	0086b783          	ld	a5,8(a3)
    800037dc:	0007b423          	sd	zero,8(a5)
    MemoryAllocator::free_memory->prev = nullptr;
    800037e0:	0007b823          	sd	zero,16(a5)

    MemoryAllocator::initialized = true;
    800037e4:	00100793          	li	a5,1
    800037e8:	00f68823          	sb	a5,16(a3)

}
    800037ec:	00813403          	ld	s0,8(sp)
    800037f0:	01010113          	addi	sp,sp,16
    800037f4:	00008067          	ret

00000000800037f8 <_ZN15MemoryAllocator16remove_from_listEP5Block>:
    size_t size_in_blocks = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
    return MemoryAllocator::malloc(size_in_blocks);
}


void MemoryAllocator::remove_from_list(Block* element){
    800037f8:	ff010113          	addi	sp,sp,-16
    800037fc:	00813423          	sd	s0,8(sp)
    80003800:	01010413          	addi	s0,sp,16
    if (element == nullptr) return;
    80003804:	02050863          	beqz	a0,80003834 <_ZN15MemoryAllocator16remove_from_listEP5Block+0x3c>

    if (MemoryAllocator::free_memory == element)
    80003808:	00009797          	auipc	a5,0x9
    8000380c:	5107b783          	ld	a5,1296(a5) # 8000cd18 <_ZN15MemoryAllocator11free_memoryE>
    80003810:	02a78863          	beq	a5,a0,80003840 <_ZN15MemoryAllocator16remove_from_listEP5Block+0x48>
        MemoryAllocator::free_memory = element->next;

    if (element->next != nullptr)
    80003814:	00853783          	ld	a5,8(a0)
    80003818:	00078663          	beqz	a5,80003824 <_ZN15MemoryAllocator16remove_from_listEP5Block+0x2c>
        element->next->prev = element->prev;
    8000381c:	01053703          	ld	a4,16(a0)
    80003820:	00e7b823          	sd	a4,16(a5)


    if (element->prev != nullptr)
    80003824:	01053783          	ld	a5,16(a0)
    80003828:	00078663          	beqz	a5,80003834 <_ZN15MemoryAllocator16remove_from_listEP5Block+0x3c>
        element->prev->next = element->next;
    8000382c:	00853703          	ld	a4,8(a0)
    80003830:	00e7b423          	sd	a4,8(a5)

}
    80003834:	00813403          	ld	s0,8(sp)
    80003838:	01010113          	addi	sp,sp,16
    8000383c:	00008067          	ret
        MemoryAllocator::free_memory = element->next;
    80003840:	00853783          	ld	a5,8(a0)
    80003844:	00009717          	auipc	a4,0x9
    80003848:	4cf73a23          	sd	a5,1236(a4) # 8000cd18 <_ZN15MemoryAllocator11free_memoryE>
    8000384c:	fc9ff06f          	j	80003814 <_ZN15MemoryAllocator16remove_from_listEP5Block+0x1c>

0000000080003850 <_ZN15MemoryAllocator14calculate_nextEP5Block>:



Block* MemoryAllocator::calculate_next(Block* element){
    80003850:	ff010113          	addi	sp,sp,-16
    80003854:	00813423          	sd	s0,8(sp)
    80003858:	01010413          	addi	s0,sp,16
    if(element == nullptr) return nullptr;
    8000385c:	02050463          	beqz	a0,80003884 <_ZN15MemoryAllocator14calculate_nextEP5Block+0x34>

    Block* next = (Block *) ((uint64) element + (element->size << mem_block_offset));
    80003860:	00053783          	ld	a5,0(a0)
    80003864:	00009717          	auipc	a4,0x9
    80003868:	4ac73703          	ld	a4,1196(a4) # 8000cd10 <_ZN15MemoryAllocator16mem_block_offsetE>
    8000386c:	00e797b3          	sll	a5,a5,a4
    80003870:	00f50533          	add	a0,a0,a5

    if((uint64)next>=(uint64)HEAP_END_ADDR) {
    80003874:	00009797          	auipc	a5,0x9
    80003878:	3d47b783          	ld	a5,980(a5) # 8000cc48 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000387c:	0007b783          	ld	a5,0(a5)
    80003880:	00f57863          	bgeu	a0,a5,80003890 <_ZN15MemoryAllocator14calculate_nextEP5Block+0x40>
        return nullptr;
    }

    return next;

}
    80003884:	00813403          	ld	s0,8(sp)
    80003888:	01010113          	addi	sp,sp,16
    8000388c:	00008067          	ret
        return nullptr;
    80003890:	00000513          	li	a0,0
    80003894:	ff1ff06f          	j	80003884 <_ZN15MemoryAllocator14calculate_nextEP5Block+0x34>

0000000080003898 <_ZN15MemoryAllocator6mallocEm>:
void* MemoryAllocator::malloc(size_t size) {
    80003898:	fe010113          	addi	sp,sp,-32
    8000389c:	00113c23          	sd	ra,24(sp)
    800038a0:	00813823          	sd	s0,16(sp)
    800038a4:	00913423          	sd	s1,8(sp)
    800038a8:	01213023          	sd	s2,0(sp)
    800038ac:	02010413          	addi	s0,sp,32
    800038b0:	00050913          	mv	s2,a0
    if(!initialized) {
    800038b4:	00009797          	auipc	a5,0x9
    800038b8:	46c7c783          	lbu	a5,1132(a5) # 8000cd20 <_ZN15MemoryAllocator11initializedE>
    800038bc:	02078263          	beqz	a5,800038e0 <_ZN15MemoryAllocator6mallocEm+0x48>
    Block* current = MemoryAllocator::free_memory;
    800038c0:	00009497          	auipc	s1,0x9
    800038c4:	4584b483          	ld	s1,1112(s1) # 8000cd18 <_ZN15MemoryAllocator11free_memoryE>
    size++;
    800038c8:	00190913          	addi	s2,s2,1
    for (; current!=nullptr; current=current->next)
    800038cc:	02048063          	beqz	s1,800038ec <_ZN15MemoryAllocator6mallocEm+0x54>
        if (current->size >= size) break;
    800038d0:	0004b783          	ld	a5,0(s1)
    800038d4:	0127fc63          	bgeu	a5,s2,800038ec <_ZN15MemoryAllocator6mallocEm+0x54>
    for (; current!=nullptr; current=current->next)
    800038d8:	0084b483          	ld	s1,8(s1)
    800038dc:	ff1ff06f          	j	800038cc <_ZN15MemoryAllocator6mallocEm+0x34>
        MemoryAllocator::init();
    800038e0:	00000097          	auipc	ra,0x0
    800038e4:	e88080e7          	jalr	-376(ra) # 80003768 <_ZN15MemoryAllocator4initEv>
    800038e8:	fd9ff06f          	j	800038c0 <_ZN15MemoryAllocator6mallocEm+0x28>
    if(current == nullptr) {
    800038ec:	02048663          	beqz	s1,80003918 <_ZN15MemoryAllocator6mallocEm+0x80>
    size_t remaining_size = current->size - size;
    800038f0:	0004b783          	ld	a5,0(s1)
    800038f4:	412787b3          	sub	a5,a5,s2
    if(remaining_size < 2*MEM_BLOCK_SIZE){
    800038f8:	07f00713          	li	a4,127
    800038fc:	02f77c63          	bgeu	a4,a5,80003934 <_ZN15MemoryAllocator6mallocEm+0x9c>
        current->size  = remaining_size;
    80003900:	00f4b023          	sd	a5,0(s1)
        Block* allocated_block = MemoryAllocator::calculate_next(current);
    80003904:	00048513          	mv	a0,s1
    80003908:	00000097          	auipc	ra,0x0
    8000390c:	f48080e7          	jalr	-184(ra) # 80003850 <_ZN15MemoryAllocator14calculate_nextEP5Block>
        allocated_block->size = size;
    80003910:	01253023          	sd	s2,0(a0)
        return (uint64*) ((uint64) allocated_block + MEM_BLOCK_SIZE);
    80003914:	04050493          	addi	s1,a0,64
}
    80003918:	00048513          	mv	a0,s1
    8000391c:	01813083          	ld	ra,24(sp)
    80003920:	01013403          	ld	s0,16(sp)
    80003924:	00813483          	ld	s1,8(sp)
    80003928:	00013903          	ld	s2,0(sp)
    8000392c:	02010113          	addi	sp,sp,32
    80003930:	00008067          	ret
        MemoryAllocator::remove_from_list(current);
    80003934:	00048513          	mv	a0,s1
    80003938:	00000097          	auipc	ra,0x0
    8000393c:	ec0080e7          	jalr	-320(ra) # 800037f8 <_ZN15MemoryAllocator16remove_from_listEP5Block>
        return (uint64*) ((uint64) current + MEM_BLOCK_SIZE);
    80003940:	04048493          	addi	s1,s1,64
    80003944:	fd5ff06f          	j	80003918 <_ZN15MemoryAllocator6mallocEm+0x80>

0000000080003948 <_ZN15MemoryAllocator12malloc_bytesEm>:
void* MemoryAllocator::malloc_bytes(size_t size)  {
    80003948:	ff010113          	addi	sp,sp,-16
    8000394c:	00113423          	sd	ra,8(sp)
    80003950:	00813023          	sd	s0,0(sp)
    80003954:	01010413          	addi	s0,sp,16
    size_t size_in_blocks = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
    80003958:	03f57793          	andi	a5,a0,63
    8000395c:	02078263          	beqz	a5,80003980 <_ZN15MemoryAllocator12malloc_bytesEm+0x38>
    80003960:	00655513          	srli	a0,a0,0x6
    80003964:	00150513          	addi	a0,a0,1
    return MemoryAllocator::malloc(size_in_blocks);
    80003968:	00000097          	auipc	ra,0x0
    8000396c:	f30080e7          	jalr	-208(ra) # 80003898 <_ZN15MemoryAllocator6mallocEm>
}
    80003970:	00813083          	ld	ra,8(sp)
    80003974:	00013403          	ld	s0,0(sp)
    80003978:	01010113          	addi	sp,sp,16
    8000397c:	00008067          	ret
    size_t size_in_blocks = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
    80003980:	00655513          	srli	a0,a0,0x6
    80003984:	fe5ff06f          	j	80003968 <_ZN15MemoryAllocator12malloc_bytesEm+0x20>

0000000080003988 <_ZN15MemoryAllocator4freeEPv>:
    if(ptr==nullptr) return -1;
    80003988:	18050c63          	beqz	a0,80003b20 <_ZN15MemoryAllocator4freeEPv+0x198>
int MemoryAllocator:: free(void* ptr){
    8000398c:	fc010113          	addi	sp,sp,-64
    80003990:	02113c23          	sd	ra,56(sp)
    80003994:	02813823          	sd	s0,48(sp)
    80003998:	02913423          	sd	s1,40(sp)
    8000399c:	03213023          	sd	s2,32(sp)
    800039a0:	01313c23          	sd	s3,24(sp)
    800039a4:	01413823          	sd	s4,16(sp)
    800039a8:	01513423          	sd	s5,8(sp)
    800039ac:	04010413          	addi	s0,sp,64
    800039b0:	00050993          	mv	s3,a0
    Block* header = (Block*) ((size_t)ptr - MEM_BLOCK_SIZE);
    800039b4:	fc050913          	addi	s2,a0,-64
    800039b8:	00090a93          	mv	s5,s2
    if(header==nullptr) return -2;
    800039bc:	16090663          	beqz	s2,80003b28 <_ZN15MemoryAllocator4freeEPv+0x1a0>
    if(MemoryAllocator::free_memory==nullptr || (uint64) header < (uint64) MemoryAllocator::free_memory){
    800039c0:	00009a17          	auipc	s4,0x9
    800039c4:	358a3a03          	ld	s4,856(s4) # 8000cd18 <_ZN15MemoryAllocator11free_memoryE>
    800039c8:	060a0463          	beqz	s4,80003a30 <_ZN15MemoryAllocator4freeEPv+0xa8>
    800039cc:	07496663          	bltu	s2,s4,80003a38 <_ZN15MemoryAllocator4freeEPv+0xb0>
        for (current = MemoryAllocator::free_memory; current!=nullptr
    800039d0:	000a0493          	mv	s1,s4
    800039d4:	0080006f          	j	800039dc <_ZN15MemoryAllocator4freeEPv+0x54>
             current=current->next);
    800039d8:	00078493          	mv	s1,a5
                                                     && (uint64)current->next < (uint64)header;
    800039dc:	00048863          	beqz	s1,800039ec <_ZN15MemoryAllocator4freeEPv+0x64>
                                                     && current->next!=nullptr
    800039e0:	0084b783          	ld	a5,8(s1)
    800039e4:	00078463          	beqz	a5,800039ec <_ZN15MemoryAllocator4freeEPv+0x64>
                                                     && (uint64)current->next < (uint64)header;
    800039e8:	ff27e8e3          	bltu	a5,s2,800039d8 <_ZN15MemoryAllocator4freeEPv+0x50>
    if(current && MemoryAllocator::calculate_next(current) == header){
    800039ec:	04048863          	beqz	s1,80003a3c <_ZN15MemoryAllocator4freeEPv+0xb4>
    800039f0:	00048513          	mv	a0,s1
    800039f4:	00000097          	auipc	ra,0x0
    800039f8:	e5c080e7          	jalr	-420(ra) # 80003850 <_ZN15MemoryAllocator14calculate_nextEP5Block>
    800039fc:	04aa9063          	bne	s5,a0,80003a3c <_ZN15MemoryAllocator4freeEPv+0xb4>
        current->size += header->size;
    80003a00:	fc09b903          	ld	s2,-64(s3)
    80003a04:	0004b783          	ld	a5,0(s1)
    80003a08:	00f90933          	add	s2,s2,a5
    80003a0c:	0124b023          	sd	s2,0(s1)
        if(current->next && calculate_next(current)==current->next ){
    80003a10:	0084b983          	ld	s3,8(s1)
    80003a14:	00098a63          	beqz	s3,80003a28 <_ZN15MemoryAllocator4freeEPv+0xa0>
    80003a18:	00048513          	mv	a0,s1
    80003a1c:	00000097          	auipc	ra,0x0
    80003a20:	e34080e7          	jalr	-460(ra) # 80003850 <_ZN15MemoryAllocator14calculate_nextEP5Block>
    80003a24:	08a98263          	beq	s3,a0,80003aa8 <_ZN15MemoryAllocator4freeEPv+0x120>
        return 0;
    80003a28:	00000513          	li	a0,0
    80003a2c:	0500006f          	j	80003a7c <_ZN15MemoryAllocator4freeEPv+0xf4>
        current = nullptr;
    80003a30:	000a0493          	mv	s1,s4
    80003a34:	0080006f          	j	80003a3c <_ZN15MemoryAllocator4freeEPv+0xb4>
    80003a38:	00000493          	li	s1,0
        Block* next_block = current?current->next:MemoryAllocator::free_memory;
    80003a3c:	06048263          	beqz	s1,80003aa0 <_ZN15MemoryAllocator4freeEPv+0x118>
    80003a40:	0084ba83          	ld	s5,8(s1)
        if(next_block && MemoryAllocator::calculate_next(header)==next_block){
    80003a44:	000a8a63          	beqz	s5,80003a58 <_ZN15MemoryAllocator4freeEPv+0xd0>
    80003a48:	00090513          	mv	a0,s2
    80003a4c:	00000097          	auipc	ra,0x0
    80003a50:	e04080e7          	jalr	-508(ra) # 80003850 <_ZN15MemoryAllocator14calculate_nextEP5Block>
    80003a54:	06aa8a63          	beq	s5,a0,80003ac8 <_ZN15MemoryAllocator4freeEPv+0x140>
    header->prev = current;
    80003a58:	00993823          	sd	s1,16(s2)
    if(current) {
    80003a5c:	0a048a63          	beqz	s1,80003b10 <_ZN15MemoryAllocator4freeEPv+0x188>
        header->next = current->next;
    80003a60:	0084b783          	ld	a5,8(s1)
    80003a64:	00f93423          	sd	a5,8(s2)
        current->next = header;
    80003a68:	0124b423          	sd	s2,8(s1)
    if(header->next){
    80003a6c:	00893783          	ld	a5,8(s2)
    80003a70:	0c078063          	beqz	a5,80003b30 <_ZN15MemoryAllocator4freeEPv+0x1a8>
        header->next->prev = header;
    80003a74:	0127b823          	sd	s2,16(a5)
    return 0;
    80003a78:	00000513          	li	a0,0
}
    80003a7c:	03813083          	ld	ra,56(sp)
    80003a80:	03013403          	ld	s0,48(sp)
    80003a84:	02813483          	ld	s1,40(sp)
    80003a88:	02013903          	ld	s2,32(sp)
    80003a8c:	01813983          	ld	s3,24(sp)
    80003a90:	01013a03          	ld	s4,16(sp)
    80003a94:	00813a83          	ld	s5,8(sp)
    80003a98:	04010113          	addi	sp,sp,64
    80003a9c:	00008067          	ret
        Block* next_block = current?current->next:MemoryAllocator::free_memory;
    80003aa0:	000a0a93          	mv	s5,s4
    80003aa4:	fa1ff06f          	j	80003a44 <_ZN15MemoryAllocator4freeEPv+0xbc>
            current->size+= current->next->size;
    80003aa8:	0009b783          	ld	a5,0(s3)
    80003aac:	00f90933          	add	s2,s2,a5
    80003ab0:	0124b023          	sd	s2,0(s1)
            current->next = current->next->next;
    80003ab4:	0089b783          	ld	a5,8(s3)
    80003ab8:	00f4b423          	sd	a5,8(s1)
            if(current->next) current->next->prev = current;
    80003abc:	f60786e3          	beqz	a5,80003a28 <_ZN15MemoryAllocator4freeEPv+0xa0>
    80003ac0:	0097b823          	sd	s1,16(a5)
    80003ac4:	f65ff06f          	j	80003a28 <_ZN15MemoryAllocator4freeEPv+0xa0>
            header->size+=next_block->size;
    80003ac8:	000ab703          	ld	a4,0(s5)
    80003acc:	fc09b783          	ld	a5,-64(s3)
    80003ad0:	00e787b3          	add	a5,a5,a4
    80003ad4:	fcf9b023          	sd	a5,-64(s3)
            header->next = next_block->next;
    80003ad8:	008ab783          	ld	a5,8(s5)
    80003adc:	00f93423          	sd	a5,8(s2)
            header->prev = next_block->prev;
    80003ae0:	010ab783          	ld	a5,16(s5)
    80003ae4:	00f93823          	sd	a5,16(s2)
            if(next_block->prev) next_block->prev->next = header;
    80003ae8:	00078e63          	beqz	a5,80003b04 <_ZN15MemoryAllocator4freeEPv+0x17c>
    80003aec:	0127b423          	sd	s2,8(a5)
            if(next_block->next) next_block->next->prev = header;
    80003af0:	008ab783          	ld	a5,8(s5)
    80003af4:	00078463          	beqz	a5,80003afc <_ZN15MemoryAllocator4freeEPv+0x174>
    80003af8:	0127b823          	sd	s2,16(a5)
            return 0;
    80003afc:	00000513          	li	a0,0
    80003b00:	f7dff06f          	j	80003a7c <_ZN15MemoryAllocator4freeEPv+0xf4>
            else MemoryAllocator::free_memory= header;
    80003b04:	00009797          	auipc	a5,0x9
    80003b08:	2127ba23          	sd	s2,532(a5) # 8000cd18 <_ZN15MemoryAllocator11free_memoryE>
    80003b0c:	fe5ff06f          	j	80003af0 <_ZN15MemoryAllocator4freeEPv+0x168>
        header->next = MemoryAllocator::free_memory;
    80003b10:	01493423          	sd	s4,8(s2)
        MemoryAllocator::free_memory=header;
    80003b14:	00009797          	auipc	a5,0x9
    80003b18:	2127b223          	sd	s2,516(a5) # 8000cd18 <_ZN15MemoryAllocator11free_memoryE>
    80003b1c:	f51ff06f          	j	80003a6c <_ZN15MemoryAllocator4freeEPv+0xe4>
    if(ptr==nullptr) return -1;
    80003b20:	fff00513          	li	a0,-1
}
    80003b24:	00008067          	ret
    if(header==nullptr) return -2;
    80003b28:	ffe00513          	li	a0,-2
    80003b2c:	f51ff06f          	j	80003a7c <_ZN15MemoryAllocator4freeEPv+0xf4>
    return 0;
    80003b30:	00000513          	li	a0,0
    80003b34:	f49ff06f          	j	80003a7c <_ZN15MemoryAllocator4freeEPv+0xf4>

0000000080003b38 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80003b38:	fe010113          	addi	sp,sp,-32
    80003b3c:	00113c23          	sd	ra,24(sp)
    80003b40:	00813823          	sd	s0,16(sp)
    80003b44:	00913423          	sd	s1,8(sp)
    80003b48:	01213023          	sd	s2,0(sp)
    80003b4c:	02010413          	addi	s0,sp,32
    80003b50:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80003b54:	00000913          	li	s2,0
    80003b58:	00c0006f          	j	80003b64 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80003b5c:	ffffe097          	auipc	ra,0xffffe
    80003b60:	b8c080e7          	jalr	-1140(ra) # 800016e8 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80003b64:	ffffe097          	auipc	ra,0xffffe
    80003b68:	cfc080e7          	jalr	-772(ra) # 80001860 <_Z4getcv>
    80003b6c:	0005059b          	sext.w	a1,a0
    80003b70:	01b00793          	li	a5,27
    80003b74:	02f58a63          	beq	a1,a5,80003ba8 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80003b78:	0084b503          	ld	a0,8(s1)
    80003b7c:	00003097          	auipc	ra,0x3
    80003b80:	400080e7          	jalr	1024(ra) # 80006f7c <_ZN6Buffer3putEi>
        i++;
    80003b84:	0019071b          	addiw	a4,s2,1
    80003b88:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003b8c:	0004a683          	lw	a3,0(s1)
    80003b90:	0026979b          	slliw	a5,a3,0x2
    80003b94:	00d787bb          	addw	a5,a5,a3
    80003b98:	0017979b          	slliw	a5,a5,0x1
    80003b9c:	02f767bb          	remw	a5,a4,a5
    80003ba0:	fc0792e3          	bnez	a5,80003b64 <_ZL16producerKeyboardPv+0x2c>
    80003ba4:	fb9ff06f          	j	80003b5c <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80003ba8:	00100793          	li	a5,1
    80003bac:	00009717          	auipc	a4,0x9
    80003bb0:	16f72e23          	sw	a5,380(a4) # 8000cd28 <_ZL9threadEnd>
    data->buffer->put('!');
    80003bb4:	02100593          	li	a1,33
    80003bb8:	0084b503          	ld	a0,8(s1)
    80003bbc:	00003097          	auipc	ra,0x3
    80003bc0:	3c0080e7          	jalr	960(ra) # 80006f7c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80003bc4:	0104b503          	ld	a0,16(s1)
    80003bc8:	ffffe097          	auipc	ra,0xffffe
    80003bcc:	c28080e7          	jalr	-984(ra) # 800017f0 <_Z10sem_signalP4_sem>
}
    80003bd0:	01813083          	ld	ra,24(sp)
    80003bd4:	01013403          	ld	s0,16(sp)
    80003bd8:	00813483          	ld	s1,8(sp)
    80003bdc:	00013903          	ld	s2,0(sp)
    80003be0:	02010113          	addi	sp,sp,32
    80003be4:	00008067          	ret

0000000080003be8 <_ZL8producerPv>:

static void producer(void *arg) {
    80003be8:	fe010113          	addi	sp,sp,-32
    80003bec:	00113c23          	sd	ra,24(sp)
    80003bf0:	00813823          	sd	s0,16(sp)
    80003bf4:	00913423          	sd	s1,8(sp)
    80003bf8:	01213023          	sd	s2,0(sp)
    80003bfc:	02010413          	addi	s0,sp,32
    80003c00:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003c04:	00000913          	li	s2,0
    80003c08:	00c0006f          	j	80003c14 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80003c0c:	ffffe097          	auipc	ra,0xffffe
    80003c10:	adc080e7          	jalr	-1316(ra) # 800016e8 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80003c14:	00009797          	auipc	a5,0x9
    80003c18:	1147a783          	lw	a5,276(a5) # 8000cd28 <_ZL9threadEnd>
    80003c1c:	02079e63          	bnez	a5,80003c58 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80003c20:	0004a583          	lw	a1,0(s1)
    80003c24:	0305859b          	addiw	a1,a1,48
    80003c28:	0084b503          	ld	a0,8(s1)
    80003c2c:	00003097          	auipc	ra,0x3
    80003c30:	350080e7          	jalr	848(ra) # 80006f7c <_ZN6Buffer3putEi>
        i++;
    80003c34:	0019071b          	addiw	a4,s2,1
    80003c38:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003c3c:	0004a683          	lw	a3,0(s1)
    80003c40:	0026979b          	slliw	a5,a3,0x2
    80003c44:	00d787bb          	addw	a5,a5,a3
    80003c48:	0017979b          	slliw	a5,a5,0x1
    80003c4c:	02f767bb          	remw	a5,a4,a5
    80003c50:	fc0792e3          	bnez	a5,80003c14 <_ZL8producerPv+0x2c>
    80003c54:	fb9ff06f          	j	80003c0c <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80003c58:	0104b503          	ld	a0,16(s1)
    80003c5c:	ffffe097          	auipc	ra,0xffffe
    80003c60:	b94080e7          	jalr	-1132(ra) # 800017f0 <_Z10sem_signalP4_sem>
}
    80003c64:	01813083          	ld	ra,24(sp)
    80003c68:	01013403          	ld	s0,16(sp)
    80003c6c:	00813483          	ld	s1,8(sp)
    80003c70:	00013903          	ld	s2,0(sp)
    80003c74:	02010113          	addi	sp,sp,32
    80003c78:	00008067          	ret

0000000080003c7c <_ZL8consumerPv>:

static void consumer(void *arg) {
    80003c7c:	fd010113          	addi	sp,sp,-48
    80003c80:	02113423          	sd	ra,40(sp)
    80003c84:	02813023          	sd	s0,32(sp)
    80003c88:	00913c23          	sd	s1,24(sp)
    80003c8c:	01213823          	sd	s2,16(sp)
    80003c90:	01313423          	sd	s3,8(sp)
    80003c94:	03010413          	addi	s0,sp,48
    80003c98:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003c9c:	00000993          	li	s3,0
    80003ca0:	01c0006f          	j	80003cbc <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80003ca4:	ffffe097          	auipc	ra,0xffffe
    80003ca8:	a44080e7          	jalr	-1468(ra) # 800016e8 <_Z15thread_dispatchv>
    80003cac:	0500006f          	j	80003cfc <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003cb0:	00a00513          	li	a0,10
    80003cb4:	ffffe097          	auipc	ra,0xffffe
    80003cb8:	be0080e7          	jalr	-1056(ra) # 80001894 <_Z4putcc>
    while (!threadEnd) {
    80003cbc:	00009797          	auipc	a5,0x9
    80003cc0:	06c7a783          	lw	a5,108(a5) # 8000cd28 <_ZL9threadEnd>
    80003cc4:	06079063          	bnez	a5,80003d24 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80003cc8:	00893503          	ld	a0,8(s2)
    80003ccc:	00003097          	auipc	ra,0x3
    80003cd0:	340080e7          	jalr	832(ra) # 8000700c <_ZN6Buffer3getEv>
        i++;
    80003cd4:	0019849b          	addiw	s1,s3,1
    80003cd8:	0004899b          	sext.w	s3,s1
        putc(key);
    80003cdc:	0ff57513          	andi	a0,a0,255
    80003ce0:	ffffe097          	auipc	ra,0xffffe
    80003ce4:	bb4080e7          	jalr	-1100(ra) # 80001894 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003ce8:	00092703          	lw	a4,0(s2)
    80003cec:	0027179b          	slliw	a5,a4,0x2
    80003cf0:	00e787bb          	addw	a5,a5,a4
    80003cf4:	02f4e7bb          	remw	a5,s1,a5
    80003cf8:	fa0786e3          	beqz	a5,80003ca4 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80003cfc:	05000793          	li	a5,80
    80003d00:	02f4e4bb          	remw	s1,s1,a5
    80003d04:	fa049ce3          	bnez	s1,80003cbc <_ZL8consumerPv+0x40>
    80003d08:	fa9ff06f          	j	80003cb0 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80003d0c:	00893503          	ld	a0,8(s2)
    80003d10:	00003097          	auipc	ra,0x3
    80003d14:	2fc080e7          	jalr	764(ra) # 8000700c <_ZN6Buffer3getEv>
        putc(key);
    80003d18:	0ff57513          	andi	a0,a0,255
    80003d1c:	ffffe097          	auipc	ra,0xffffe
    80003d20:	b78080e7          	jalr	-1160(ra) # 80001894 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80003d24:	00893503          	ld	a0,8(s2)
    80003d28:	00003097          	auipc	ra,0x3
    80003d2c:	370080e7          	jalr	880(ra) # 80007098 <_ZN6Buffer6getCntEv>
    80003d30:	fca04ee3          	bgtz	a0,80003d0c <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80003d34:	01093503          	ld	a0,16(s2)
    80003d38:	ffffe097          	auipc	ra,0xffffe
    80003d3c:	ab8080e7          	jalr	-1352(ra) # 800017f0 <_Z10sem_signalP4_sem>
}
    80003d40:	02813083          	ld	ra,40(sp)
    80003d44:	02013403          	ld	s0,32(sp)
    80003d48:	01813483          	ld	s1,24(sp)
    80003d4c:	01013903          	ld	s2,16(sp)
    80003d50:	00813983          	ld	s3,8(sp)
    80003d54:	03010113          	addi	sp,sp,48
    80003d58:	00008067          	ret

0000000080003d5c <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80003d5c:	f9010113          	addi	sp,sp,-112
    80003d60:	06113423          	sd	ra,104(sp)
    80003d64:	06813023          	sd	s0,96(sp)
    80003d68:	04913c23          	sd	s1,88(sp)
    80003d6c:	05213823          	sd	s2,80(sp)
    80003d70:	05313423          	sd	s3,72(sp)
    80003d74:	05413023          	sd	s4,64(sp)
    80003d78:	03513c23          	sd	s5,56(sp)
    80003d7c:	03613823          	sd	s6,48(sp)
    80003d80:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80003d84:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80003d88:	00006517          	auipc	a0,0x6
    80003d8c:	32850513          	addi	a0,a0,808 # 8000a0b0 <CONSOLE_STATUS+0xa0>
    80003d90:	00002097          	auipc	ra,0x2
    80003d94:	220080e7          	jalr	544(ra) # 80005fb0 <_Z11printStringPKc>
    getString(input, 30);
    80003d98:	01e00593          	li	a1,30
    80003d9c:	fa040493          	addi	s1,s0,-96
    80003da0:	00048513          	mv	a0,s1
    80003da4:	00002097          	auipc	ra,0x2
    80003da8:	294080e7          	jalr	660(ra) # 80006038 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003dac:	00048513          	mv	a0,s1
    80003db0:	00002097          	auipc	ra,0x2
    80003db4:	360080e7          	jalr	864(ra) # 80006110 <_Z11stringToIntPKc>
    80003db8:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80003dbc:	00006517          	auipc	a0,0x6
    80003dc0:	31450513          	addi	a0,a0,788 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    80003dc4:	00002097          	auipc	ra,0x2
    80003dc8:	1ec080e7          	jalr	492(ra) # 80005fb0 <_Z11printStringPKc>
    getString(input, 30);
    80003dcc:	01e00593          	li	a1,30
    80003dd0:	00048513          	mv	a0,s1
    80003dd4:	00002097          	auipc	ra,0x2
    80003dd8:	264080e7          	jalr	612(ra) # 80006038 <_Z9getStringPci>
    n = stringToInt(input);
    80003ddc:	00048513          	mv	a0,s1
    80003de0:	00002097          	auipc	ra,0x2
    80003de4:	330080e7          	jalr	816(ra) # 80006110 <_Z11stringToIntPKc>
    80003de8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003dec:	00006517          	auipc	a0,0x6
    80003df0:	30450513          	addi	a0,a0,772 # 8000a0f0 <CONSOLE_STATUS+0xe0>
    80003df4:	00002097          	auipc	ra,0x2
    80003df8:	1bc080e7          	jalr	444(ra) # 80005fb0 <_Z11printStringPKc>
    80003dfc:	00000613          	li	a2,0
    80003e00:	00a00593          	li	a1,10
    80003e04:	00090513          	mv	a0,s2
    80003e08:	00002097          	auipc	ra,0x2
    80003e0c:	358080e7          	jalr	856(ra) # 80006160 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80003e10:	00006517          	auipc	a0,0x6
    80003e14:	2f850513          	addi	a0,a0,760 # 8000a108 <CONSOLE_STATUS+0xf8>
    80003e18:	00002097          	auipc	ra,0x2
    80003e1c:	198080e7          	jalr	408(ra) # 80005fb0 <_Z11printStringPKc>
    80003e20:	00000613          	li	a2,0
    80003e24:	00a00593          	li	a1,10
    80003e28:	00048513          	mv	a0,s1
    80003e2c:	00002097          	auipc	ra,0x2
    80003e30:	334080e7          	jalr	820(ra) # 80006160 <_Z8printIntiii>
    printString(".\n");
    80003e34:	00006517          	auipc	a0,0x6
    80003e38:	2ec50513          	addi	a0,a0,748 # 8000a120 <CONSOLE_STATUS+0x110>
    80003e3c:	00002097          	auipc	ra,0x2
    80003e40:	174080e7          	jalr	372(ra) # 80005fb0 <_Z11printStringPKc>
    if(threadNum > n) {
    80003e44:	0324c463          	blt	s1,s2,80003e6c <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80003e48:	03205c63          	blez	s2,80003e80 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80003e4c:	03800513          	li	a0,56
    80003e50:	ffffe097          	auipc	ra,0xffffe
    80003e54:	f78080e7          	jalr	-136(ra) # 80001dc8 <_Znwm>
    80003e58:	00050a13          	mv	s4,a0
    80003e5c:	00048593          	mv	a1,s1
    80003e60:	00003097          	auipc	ra,0x3
    80003e64:	080080e7          	jalr	128(ra) # 80006ee0 <_ZN6BufferC1Ei>
    80003e68:	0300006f          	j	80003e98 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003e6c:	00006517          	auipc	a0,0x6
    80003e70:	2bc50513          	addi	a0,a0,700 # 8000a128 <CONSOLE_STATUS+0x118>
    80003e74:	00002097          	auipc	ra,0x2
    80003e78:	13c080e7          	jalr	316(ra) # 80005fb0 <_Z11printStringPKc>
        return;
    80003e7c:	0140006f          	j	80003e90 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003e80:	00006517          	auipc	a0,0x6
    80003e84:	2e850513          	addi	a0,a0,744 # 8000a168 <CONSOLE_STATUS+0x158>
    80003e88:	00002097          	auipc	ra,0x2
    80003e8c:	128080e7          	jalr	296(ra) # 80005fb0 <_Z11printStringPKc>
        return;
    80003e90:	000b0113          	mv	sp,s6
    80003e94:	1500006f          	j	80003fe4 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80003e98:	00000593          	li	a1,0
    80003e9c:	00009517          	auipc	a0,0x9
    80003ea0:	e9450513          	addi	a0,a0,-364 # 8000cd30 <_ZL10waitForAll>
    80003ea4:	ffffe097          	auipc	ra,0xffffe
    80003ea8:	898080e7          	jalr	-1896(ra) # 8000173c <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    80003eac:	00391793          	slli	a5,s2,0x3
    80003eb0:	00f78793          	addi	a5,a5,15
    80003eb4:	ff07f793          	andi	a5,a5,-16
    80003eb8:	40f10133          	sub	sp,sp,a5
    80003ebc:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80003ec0:	0019071b          	addiw	a4,s2,1
    80003ec4:	00171793          	slli	a5,a4,0x1
    80003ec8:	00e787b3          	add	a5,a5,a4
    80003ecc:	00379793          	slli	a5,a5,0x3
    80003ed0:	00f78793          	addi	a5,a5,15
    80003ed4:	ff07f793          	andi	a5,a5,-16
    80003ed8:	40f10133          	sub	sp,sp,a5
    80003edc:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80003ee0:	00191613          	slli	a2,s2,0x1
    80003ee4:	012607b3          	add	a5,a2,s2
    80003ee8:	00379793          	slli	a5,a5,0x3
    80003eec:	00f987b3          	add	a5,s3,a5
    80003ef0:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003ef4:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80003ef8:	00009717          	auipc	a4,0x9
    80003efc:	e3873703          	ld	a4,-456(a4) # 8000cd30 <_ZL10waitForAll>
    80003f00:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80003f04:	00078613          	mv	a2,a5
    80003f08:	00000597          	auipc	a1,0x0
    80003f0c:	d7458593          	addi	a1,a1,-652 # 80003c7c <_ZL8consumerPv>
    80003f10:	f9840513          	addi	a0,s0,-104
    80003f14:	ffffd097          	auipc	ra,0xffffd
    80003f18:	6cc080e7          	jalr	1740(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003f1c:	00000493          	li	s1,0
    80003f20:	0280006f          	j	80003f48 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80003f24:	00000597          	auipc	a1,0x0
    80003f28:	c1458593          	addi	a1,a1,-1004 # 80003b38 <_ZL16producerKeyboardPv>
                      data + i);
    80003f2c:	00179613          	slli	a2,a5,0x1
    80003f30:	00f60633          	add	a2,a2,a5
    80003f34:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80003f38:	00c98633          	add	a2,s3,a2
    80003f3c:	ffffd097          	auipc	ra,0xffffd
    80003f40:	6a4080e7          	jalr	1700(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003f44:	0014849b          	addiw	s1,s1,1
    80003f48:	0524d263          	bge	s1,s2,80003f8c <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80003f4c:	00149793          	slli	a5,s1,0x1
    80003f50:	009787b3          	add	a5,a5,s1
    80003f54:	00379793          	slli	a5,a5,0x3
    80003f58:	00f987b3          	add	a5,s3,a5
    80003f5c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003f60:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80003f64:	00009717          	auipc	a4,0x9
    80003f68:	dcc73703          	ld	a4,-564(a4) # 8000cd30 <_ZL10waitForAll>
    80003f6c:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80003f70:	00048793          	mv	a5,s1
    80003f74:	00349513          	slli	a0,s1,0x3
    80003f78:	00aa8533          	add	a0,s5,a0
    80003f7c:	fa9054e3          	blez	s1,80003f24 <_Z22producerConsumer_C_APIv+0x1c8>
    80003f80:	00000597          	auipc	a1,0x0
    80003f84:	c6858593          	addi	a1,a1,-920 # 80003be8 <_ZL8producerPv>
    80003f88:	fa5ff06f          	j	80003f2c <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80003f8c:	ffffd097          	auipc	ra,0xffffd
    80003f90:	75c080e7          	jalr	1884(ra) # 800016e8 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80003f94:	00000493          	li	s1,0
    80003f98:	00994e63          	blt	s2,s1,80003fb4 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80003f9c:	00009517          	auipc	a0,0x9
    80003fa0:	d9453503          	ld	a0,-620(a0) # 8000cd30 <_ZL10waitForAll>
    80003fa4:	ffffe097          	auipc	ra,0xffffe
    80003fa8:	814080e7          	jalr	-2028(ra) # 800017b8 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    80003fac:	0014849b          	addiw	s1,s1,1
    80003fb0:	fe9ff06f          	j	80003f98 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80003fb4:	00009517          	auipc	a0,0x9
    80003fb8:	d7c53503          	ld	a0,-644(a0) # 8000cd30 <_ZL10waitForAll>
    80003fbc:	ffffd097          	auipc	ra,0xffffd
    80003fc0:	7c4080e7          	jalr	1988(ra) # 80001780 <_Z9sem_closeP4_sem>
    delete buffer;
    80003fc4:	000a0e63          	beqz	s4,80003fe0 <_Z22producerConsumer_C_APIv+0x284>
    80003fc8:	000a0513          	mv	a0,s4
    80003fcc:	00003097          	auipc	ra,0x3
    80003fd0:	154080e7          	jalr	340(ra) # 80007120 <_ZN6BufferD1Ev>
    80003fd4:	000a0513          	mv	a0,s4
    80003fd8:	ffffe097          	auipc	ra,0xffffe
    80003fdc:	e40080e7          	jalr	-448(ra) # 80001e18 <_ZdlPv>
    80003fe0:	000b0113          	mv	sp,s6

}
    80003fe4:	f9040113          	addi	sp,s0,-112
    80003fe8:	06813083          	ld	ra,104(sp)
    80003fec:	06013403          	ld	s0,96(sp)
    80003ff0:	05813483          	ld	s1,88(sp)
    80003ff4:	05013903          	ld	s2,80(sp)
    80003ff8:	04813983          	ld	s3,72(sp)
    80003ffc:	04013a03          	ld	s4,64(sp)
    80004000:	03813a83          	ld	s5,56(sp)
    80004004:	03013b03          	ld	s6,48(sp)
    80004008:	07010113          	addi	sp,sp,112
    8000400c:	00008067          	ret
    80004010:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80004014:	000a0513          	mv	a0,s4
    80004018:	ffffe097          	auipc	ra,0xffffe
    8000401c:	e00080e7          	jalr	-512(ra) # 80001e18 <_ZdlPv>
    80004020:	00048513          	mv	a0,s1
    80004024:	0000a097          	auipc	ra,0xa
    80004028:	e24080e7          	jalr	-476(ra) # 8000de48 <_Unwind_Resume>

000000008000402c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    8000402c:	fe010113          	addi	sp,sp,-32
    80004030:	00113c23          	sd	ra,24(sp)
    80004034:	00813823          	sd	s0,16(sp)
    80004038:	00913423          	sd	s1,8(sp)
    8000403c:	01213023          	sd	s2,0(sp)
    80004040:	02010413          	addi	s0,sp,32
    80004044:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004048:	00100793          	li	a5,1
    8000404c:	02a7f863          	bgeu	a5,a0,8000407c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004050:	00a00793          	li	a5,10
    80004054:	02f577b3          	remu	a5,a0,a5
    80004058:	02078e63          	beqz	a5,80004094 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000405c:	fff48513          	addi	a0,s1,-1
    80004060:	00000097          	auipc	ra,0x0
    80004064:	fcc080e7          	jalr	-52(ra) # 8000402c <_ZL9fibonaccim>
    80004068:	00050913          	mv	s2,a0
    8000406c:	ffe48513          	addi	a0,s1,-2
    80004070:	00000097          	auipc	ra,0x0
    80004074:	fbc080e7          	jalr	-68(ra) # 8000402c <_ZL9fibonaccim>
    80004078:	00a90533          	add	a0,s2,a0
}
    8000407c:	01813083          	ld	ra,24(sp)
    80004080:	01013403          	ld	s0,16(sp)
    80004084:	00813483          	ld	s1,8(sp)
    80004088:	00013903          	ld	s2,0(sp)
    8000408c:	02010113          	addi	sp,sp,32
    80004090:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004094:	ffffd097          	auipc	ra,0xffffd
    80004098:	654080e7          	jalr	1620(ra) # 800016e8 <_Z15thread_dispatchv>
    8000409c:	fc1ff06f          	j	8000405c <_ZL9fibonaccim+0x30>

00000000800040a0 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800040a0:	fe010113          	addi	sp,sp,-32
    800040a4:	00113c23          	sd	ra,24(sp)
    800040a8:	00813823          	sd	s0,16(sp)
    800040ac:	00913423          	sd	s1,8(sp)
    800040b0:	01213023          	sd	s2,0(sp)
    800040b4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800040b8:	00000913          	li	s2,0
    800040bc:	0380006f          	j	800040f4 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800040c0:	ffffd097          	auipc	ra,0xffffd
    800040c4:	628080e7          	jalr	1576(ra) # 800016e8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800040c8:	00148493          	addi	s1,s1,1
    800040cc:	000027b7          	lui	a5,0x2
    800040d0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800040d4:	0097ee63          	bltu	a5,s1,800040f0 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800040d8:	00000713          	li	a4,0
    800040dc:	000077b7          	lui	a5,0x7
    800040e0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800040e4:	fce7eee3          	bltu	a5,a4,800040c0 <_ZN7WorkerA11workerBodyAEPv+0x20>
    800040e8:	00170713          	addi	a4,a4,1
    800040ec:	ff1ff06f          	j	800040dc <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800040f0:	00190913          	addi	s2,s2,1
    800040f4:	00900793          	li	a5,9
    800040f8:	0527e063          	bltu	a5,s2,80004138 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800040fc:	00006517          	auipc	a0,0x6
    80004100:	09c50513          	addi	a0,a0,156 # 8000a198 <CONSOLE_STATUS+0x188>
    80004104:	00002097          	auipc	ra,0x2
    80004108:	eac080e7          	jalr	-340(ra) # 80005fb0 <_Z11printStringPKc>
    8000410c:	00000613          	li	a2,0
    80004110:	00a00593          	li	a1,10
    80004114:	0009051b          	sext.w	a0,s2
    80004118:	00002097          	auipc	ra,0x2
    8000411c:	048080e7          	jalr	72(ra) # 80006160 <_Z8printIntiii>
    80004120:	00006517          	auipc	a0,0x6
    80004124:	2c850513          	addi	a0,a0,712 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80004128:	00002097          	auipc	ra,0x2
    8000412c:	e88080e7          	jalr	-376(ra) # 80005fb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004130:	00000493          	li	s1,0
    80004134:	f99ff06f          	j	800040cc <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004138:	00006517          	auipc	a0,0x6
    8000413c:	06850513          	addi	a0,a0,104 # 8000a1a0 <CONSOLE_STATUS+0x190>
    80004140:	00002097          	auipc	ra,0x2
    80004144:	e70080e7          	jalr	-400(ra) # 80005fb0 <_Z11printStringPKc>
    finishedA = true;
    80004148:	00100793          	li	a5,1
    8000414c:	00009717          	auipc	a4,0x9
    80004150:	bef70623          	sb	a5,-1044(a4) # 8000cd38 <_ZL9finishedA>
}
    80004154:	01813083          	ld	ra,24(sp)
    80004158:	01013403          	ld	s0,16(sp)
    8000415c:	00813483          	ld	s1,8(sp)
    80004160:	00013903          	ld	s2,0(sp)
    80004164:	02010113          	addi	sp,sp,32
    80004168:	00008067          	ret

000000008000416c <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    8000416c:	fe010113          	addi	sp,sp,-32
    80004170:	00113c23          	sd	ra,24(sp)
    80004174:	00813823          	sd	s0,16(sp)
    80004178:	00913423          	sd	s1,8(sp)
    8000417c:	01213023          	sd	s2,0(sp)
    80004180:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004184:	00000913          	li	s2,0
    80004188:	0380006f          	j	800041c0 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000418c:	ffffd097          	auipc	ra,0xffffd
    80004190:	55c080e7          	jalr	1372(ra) # 800016e8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004194:	00148493          	addi	s1,s1,1
    80004198:	000027b7          	lui	a5,0x2
    8000419c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800041a0:	0097ee63          	bltu	a5,s1,800041bc <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800041a4:	00000713          	li	a4,0
    800041a8:	000077b7          	lui	a5,0x7
    800041ac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800041b0:	fce7eee3          	bltu	a5,a4,8000418c <_ZN7WorkerB11workerBodyBEPv+0x20>
    800041b4:	00170713          	addi	a4,a4,1
    800041b8:	ff1ff06f          	j	800041a8 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800041bc:	00190913          	addi	s2,s2,1
    800041c0:	00f00793          	li	a5,15
    800041c4:	0527e063          	bltu	a5,s2,80004204 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800041c8:	00006517          	auipc	a0,0x6
    800041cc:	fe850513          	addi	a0,a0,-24 # 8000a1b0 <CONSOLE_STATUS+0x1a0>
    800041d0:	00002097          	auipc	ra,0x2
    800041d4:	de0080e7          	jalr	-544(ra) # 80005fb0 <_Z11printStringPKc>
    800041d8:	00000613          	li	a2,0
    800041dc:	00a00593          	li	a1,10
    800041e0:	0009051b          	sext.w	a0,s2
    800041e4:	00002097          	auipc	ra,0x2
    800041e8:	f7c080e7          	jalr	-132(ra) # 80006160 <_Z8printIntiii>
    800041ec:	00006517          	auipc	a0,0x6
    800041f0:	1fc50513          	addi	a0,a0,508 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800041f4:	00002097          	auipc	ra,0x2
    800041f8:	dbc080e7          	jalr	-580(ra) # 80005fb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800041fc:	00000493          	li	s1,0
    80004200:	f99ff06f          	j	80004198 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004204:	00006517          	auipc	a0,0x6
    80004208:	fb450513          	addi	a0,a0,-76 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    8000420c:	00002097          	auipc	ra,0x2
    80004210:	da4080e7          	jalr	-604(ra) # 80005fb0 <_Z11printStringPKc>
    finishedB = true;
    80004214:	00100793          	li	a5,1
    80004218:	00009717          	auipc	a4,0x9
    8000421c:	b2f700a3          	sb	a5,-1247(a4) # 8000cd39 <_ZL9finishedB>
    thread_dispatch();
    80004220:	ffffd097          	auipc	ra,0xffffd
    80004224:	4c8080e7          	jalr	1224(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80004228:	01813083          	ld	ra,24(sp)
    8000422c:	01013403          	ld	s0,16(sp)
    80004230:	00813483          	ld	s1,8(sp)
    80004234:	00013903          	ld	s2,0(sp)
    80004238:	02010113          	addi	sp,sp,32
    8000423c:	00008067          	ret

0000000080004240 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004240:	fe010113          	addi	sp,sp,-32
    80004244:	00113c23          	sd	ra,24(sp)
    80004248:	00813823          	sd	s0,16(sp)
    8000424c:	00913423          	sd	s1,8(sp)
    80004250:	01213023          	sd	s2,0(sp)
    80004254:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004258:	00000493          	li	s1,0
    8000425c:	0400006f          	j	8000429c <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004260:	00006517          	auipc	a0,0x6
    80004264:	f6850513          	addi	a0,a0,-152 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80004268:	00002097          	auipc	ra,0x2
    8000426c:	d48080e7          	jalr	-696(ra) # 80005fb0 <_Z11printStringPKc>
    80004270:	00000613          	li	a2,0
    80004274:	00a00593          	li	a1,10
    80004278:	00048513          	mv	a0,s1
    8000427c:	00002097          	auipc	ra,0x2
    80004280:	ee4080e7          	jalr	-284(ra) # 80006160 <_Z8printIntiii>
    80004284:	00006517          	auipc	a0,0x6
    80004288:	16450513          	addi	a0,a0,356 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000428c:	00002097          	auipc	ra,0x2
    80004290:	d24080e7          	jalr	-732(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004294:	0014849b          	addiw	s1,s1,1
    80004298:	0ff4f493          	andi	s1,s1,255
    8000429c:	00200793          	li	a5,2
    800042a0:	fc97f0e3          	bgeu	a5,s1,80004260 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    800042a4:	00006517          	auipc	a0,0x6
    800042a8:	f2c50513          	addi	a0,a0,-212 # 8000a1d0 <CONSOLE_STATUS+0x1c0>
    800042ac:	00002097          	auipc	ra,0x2
    800042b0:	d04080e7          	jalr	-764(ra) # 80005fb0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800042b4:	00700313          	li	t1,7
    thread_dispatch();
    800042b8:	ffffd097          	auipc	ra,0xffffd
    800042bc:	430080e7          	jalr	1072(ra) # 800016e8 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800042c0:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800042c4:	00006517          	auipc	a0,0x6
    800042c8:	f1c50513          	addi	a0,a0,-228 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    800042cc:	00002097          	auipc	ra,0x2
    800042d0:	ce4080e7          	jalr	-796(ra) # 80005fb0 <_Z11printStringPKc>
    800042d4:	00000613          	li	a2,0
    800042d8:	00a00593          	li	a1,10
    800042dc:	0009051b          	sext.w	a0,s2
    800042e0:	00002097          	auipc	ra,0x2
    800042e4:	e80080e7          	jalr	-384(ra) # 80006160 <_Z8printIntiii>
    800042e8:	00006517          	auipc	a0,0x6
    800042ec:	10050513          	addi	a0,a0,256 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800042f0:	00002097          	auipc	ra,0x2
    800042f4:	cc0080e7          	jalr	-832(ra) # 80005fb0 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800042f8:	00c00513          	li	a0,12
    800042fc:	00000097          	auipc	ra,0x0
    80004300:	d30080e7          	jalr	-720(ra) # 8000402c <_ZL9fibonaccim>
    80004304:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004308:	00006517          	auipc	a0,0x6
    8000430c:	ee050513          	addi	a0,a0,-288 # 8000a1e8 <CONSOLE_STATUS+0x1d8>
    80004310:	00002097          	auipc	ra,0x2
    80004314:	ca0080e7          	jalr	-864(ra) # 80005fb0 <_Z11printStringPKc>
    80004318:	00000613          	li	a2,0
    8000431c:	00a00593          	li	a1,10
    80004320:	0009051b          	sext.w	a0,s2
    80004324:	00002097          	auipc	ra,0x2
    80004328:	e3c080e7          	jalr	-452(ra) # 80006160 <_Z8printIntiii>
    8000432c:	00006517          	auipc	a0,0x6
    80004330:	0bc50513          	addi	a0,a0,188 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80004334:	00002097          	auipc	ra,0x2
    80004338:	c7c080e7          	jalr	-900(ra) # 80005fb0 <_Z11printStringPKc>
    8000433c:	0400006f          	j	8000437c <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004340:	00006517          	auipc	a0,0x6
    80004344:	e8850513          	addi	a0,a0,-376 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80004348:	00002097          	auipc	ra,0x2
    8000434c:	c68080e7          	jalr	-920(ra) # 80005fb0 <_Z11printStringPKc>
    80004350:	00000613          	li	a2,0
    80004354:	00a00593          	li	a1,10
    80004358:	00048513          	mv	a0,s1
    8000435c:	00002097          	auipc	ra,0x2
    80004360:	e04080e7          	jalr	-508(ra) # 80006160 <_Z8printIntiii>
    80004364:	00006517          	auipc	a0,0x6
    80004368:	08450513          	addi	a0,a0,132 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000436c:	00002097          	auipc	ra,0x2
    80004370:	c44080e7          	jalr	-956(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004374:	0014849b          	addiw	s1,s1,1
    80004378:	0ff4f493          	andi	s1,s1,255
    8000437c:	00500793          	li	a5,5
    80004380:	fc97f0e3          	bgeu	a5,s1,80004340 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80004384:	00006517          	auipc	a0,0x6
    80004388:	e1c50513          	addi	a0,a0,-484 # 8000a1a0 <CONSOLE_STATUS+0x190>
    8000438c:	00002097          	auipc	ra,0x2
    80004390:	c24080e7          	jalr	-988(ra) # 80005fb0 <_Z11printStringPKc>
    finishedC = true;
    80004394:	00100793          	li	a5,1
    80004398:	00009717          	auipc	a4,0x9
    8000439c:	9af70123          	sb	a5,-1630(a4) # 8000cd3a <_ZL9finishedC>
    thread_dispatch();
    800043a0:	ffffd097          	auipc	ra,0xffffd
    800043a4:	348080e7          	jalr	840(ra) # 800016e8 <_Z15thread_dispatchv>
}
    800043a8:	01813083          	ld	ra,24(sp)
    800043ac:	01013403          	ld	s0,16(sp)
    800043b0:	00813483          	ld	s1,8(sp)
    800043b4:	00013903          	ld	s2,0(sp)
    800043b8:	02010113          	addi	sp,sp,32
    800043bc:	00008067          	ret

00000000800043c0 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    800043c0:	fe010113          	addi	sp,sp,-32
    800043c4:	00113c23          	sd	ra,24(sp)
    800043c8:	00813823          	sd	s0,16(sp)
    800043cc:	00913423          	sd	s1,8(sp)
    800043d0:	01213023          	sd	s2,0(sp)
    800043d4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800043d8:	00a00493          	li	s1,10
    800043dc:	0400006f          	j	8000441c <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800043e0:	00006517          	auipc	a0,0x6
    800043e4:	e1850513          	addi	a0,a0,-488 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    800043e8:	00002097          	auipc	ra,0x2
    800043ec:	bc8080e7          	jalr	-1080(ra) # 80005fb0 <_Z11printStringPKc>
    800043f0:	00000613          	li	a2,0
    800043f4:	00a00593          	li	a1,10
    800043f8:	00048513          	mv	a0,s1
    800043fc:	00002097          	auipc	ra,0x2
    80004400:	d64080e7          	jalr	-668(ra) # 80006160 <_Z8printIntiii>
    80004404:	00006517          	auipc	a0,0x6
    80004408:	fe450513          	addi	a0,a0,-28 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000440c:	00002097          	auipc	ra,0x2
    80004410:	ba4080e7          	jalr	-1116(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004414:	0014849b          	addiw	s1,s1,1
    80004418:	0ff4f493          	andi	s1,s1,255
    8000441c:	00c00793          	li	a5,12
    80004420:	fc97f0e3          	bgeu	a5,s1,800043e0 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80004424:	00006517          	auipc	a0,0x6
    80004428:	ddc50513          	addi	a0,a0,-548 # 8000a200 <CONSOLE_STATUS+0x1f0>
    8000442c:	00002097          	auipc	ra,0x2
    80004430:	b84080e7          	jalr	-1148(ra) # 80005fb0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004434:	00500313          	li	t1,5
    thread_dispatch();
    80004438:	ffffd097          	auipc	ra,0xffffd
    8000443c:	2b0080e7          	jalr	688(ra) # 800016e8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004440:	01000513          	li	a0,16
    80004444:	00000097          	auipc	ra,0x0
    80004448:	be8080e7          	jalr	-1048(ra) # 8000402c <_ZL9fibonaccim>
    8000444c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004450:	00006517          	auipc	a0,0x6
    80004454:	dc050513          	addi	a0,a0,-576 # 8000a210 <CONSOLE_STATUS+0x200>
    80004458:	00002097          	auipc	ra,0x2
    8000445c:	b58080e7          	jalr	-1192(ra) # 80005fb0 <_Z11printStringPKc>
    80004460:	00000613          	li	a2,0
    80004464:	00a00593          	li	a1,10
    80004468:	0009051b          	sext.w	a0,s2
    8000446c:	00002097          	auipc	ra,0x2
    80004470:	cf4080e7          	jalr	-780(ra) # 80006160 <_Z8printIntiii>
    80004474:	00006517          	auipc	a0,0x6
    80004478:	f7450513          	addi	a0,a0,-140 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000447c:	00002097          	auipc	ra,0x2
    80004480:	b34080e7          	jalr	-1228(ra) # 80005fb0 <_Z11printStringPKc>
    80004484:	0400006f          	j	800044c4 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004488:	00006517          	auipc	a0,0x6
    8000448c:	d7050513          	addi	a0,a0,-656 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80004490:	00002097          	auipc	ra,0x2
    80004494:	b20080e7          	jalr	-1248(ra) # 80005fb0 <_Z11printStringPKc>
    80004498:	00000613          	li	a2,0
    8000449c:	00a00593          	li	a1,10
    800044a0:	00048513          	mv	a0,s1
    800044a4:	00002097          	auipc	ra,0x2
    800044a8:	cbc080e7          	jalr	-836(ra) # 80006160 <_Z8printIntiii>
    800044ac:	00006517          	auipc	a0,0x6
    800044b0:	f3c50513          	addi	a0,a0,-196 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800044b4:	00002097          	auipc	ra,0x2
    800044b8:	afc080e7          	jalr	-1284(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800044bc:	0014849b          	addiw	s1,s1,1
    800044c0:	0ff4f493          	andi	s1,s1,255
    800044c4:	00f00793          	li	a5,15
    800044c8:	fc97f0e3          	bgeu	a5,s1,80004488 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    800044cc:	00006517          	auipc	a0,0x6
    800044d0:	d5450513          	addi	a0,a0,-684 # 8000a220 <CONSOLE_STATUS+0x210>
    800044d4:	00002097          	auipc	ra,0x2
    800044d8:	adc080e7          	jalr	-1316(ra) # 80005fb0 <_Z11printStringPKc>
    finishedD = true;
    800044dc:	00100793          	li	a5,1
    800044e0:	00009717          	auipc	a4,0x9
    800044e4:	84f70da3          	sb	a5,-1957(a4) # 8000cd3b <_ZL9finishedD>
    thread_dispatch();
    800044e8:	ffffd097          	auipc	ra,0xffffd
    800044ec:	200080e7          	jalr	512(ra) # 800016e8 <_Z15thread_dispatchv>
}
    800044f0:	01813083          	ld	ra,24(sp)
    800044f4:	01013403          	ld	s0,16(sp)
    800044f8:	00813483          	ld	s1,8(sp)
    800044fc:	00013903          	ld	s2,0(sp)
    80004500:	02010113          	addi	sp,sp,32
    80004504:	00008067          	ret

0000000080004508 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80004508:	fc010113          	addi	sp,sp,-64
    8000450c:	02113c23          	sd	ra,56(sp)
    80004510:	02813823          	sd	s0,48(sp)
    80004514:	02913423          	sd	s1,40(sp)
    80004518:	03213023          	sd	s2,32(sp)
    8000451c:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80004520:	02000513          	li	a0,32
    80004524:	ffffe097          	auipc	ra,0xffffe
    80004528:	8a4080e7          	jalr	-1884(ra) # 80001dc8 <_Znwm>
    8000452c:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80004530:	ffffe097          	auipc	ra,0xffffe
    80004534:	a98080e7          	jalr	-1384(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80004538:	00008797          	auipc	a5,0x8
    8000453c:	52078793          	addi	a5,a5,1312 # 8000ca58 <_ZTV7WorkerA+0x10>
    80004540:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80004544:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80004548:	00006517          	auipc	a0,0x6
    8000454c:	ce850513          	addi	a0,a0,-792 # 8000a230 <CONSOLE_STATUS+0x220>
    80004550:	00002097          	auipc	ra,0x2
    80004554:	a60080e7          	jalr	-1440(ra) # 80005fb0 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80004558:	02000513          	li	a0,32
    8000455c:	ffffe097          	auipc	ra,0xffffe
    80004560:	86c080e7          	jalr	-1940(ra) # 80001dc8 <_Znwm>
    80004564:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80004568:	ffffe097          	auipc	ra,0xffffe
    8000456c:	a60080e7          	jalr	-1440(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80004570:	00008797          	auipc	a5,0x8
    80004574:	51078793          	addi	a5,a5,1296 # 8000ca80 <_ZTV7WorkerB+0x10>
    80004578:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    8000457c:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80004580:	00006517          	auipc	a0,0x6
    80004584:	cc850513          	addi	a0,a0,-824 # 8000a248 <CONSOLE_STATUS+0x238>
    80004588:	00002097          	auipc	ra,0x2
    8000458c:	a28080e7          	jalr	-1496(ra) # 80005fb0 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80004590:	02000513          	li	a0,32
    80004594:	ffffe097          	auipc	ra,0xffffe
    80004598:	834080e7          	jalr	-1996(ra) # 80001dc8 <_Znwm>
    8000459c:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    800045a0:	ffffe097          	auipc	ra,0xffffe
    800045a4:	a28080e7          	jalr	-1496(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    800045a8:	00008797          	auipc	a5,0x8
    800045ac:	50078793          	addi	a5,a5,1280 # 8000caa8 <_ZTV7WorkerC+0x10>
    800045b0:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    800045b4:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    800045b8:	00006517          	auipc	a0,0x6
    800045bc:	ca850513          	addi	a0,a0,-856 # 8000a260 <CONSOLE_STATUS+0x250>
    800045c0:	00002097          	auipc	ra,0x2
    800045c4:	9f0080e7          	jalr	-1552(ra) # 80005fb0 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    800045c8:	02000513          	li	a0,32
    800045cc:	ffffd097          	auipc	ra,0xffffd
    800045d0:	7fc080e7          	jalr	2044(ra) # 80001dc8 <_Znwm>
    800045d4:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    800045d8:	ffffe097          	auipc	ra,0xffffe
    800045dc:	9f0080e7          	jalr	-1552(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    800045e0:	00008797          	auipc	a5,0x8
    800045e4:	4f078793          	addi	a5,a5,1264 # 8000cad0 <_ZTV7WorkerD+0x10>
    800045e8:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    800045ec:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    800045f0:	00006517          	auipc	a0,0x6
    800045f4:	c8850513          	addi	a0,a0,-888 # 8000a278 <CONSOLE_STATUS+0x268>
    800045f8:	00002097          	auipc	ra,0x2
    800045fc:	9b8080e7          	jalr	-1608(ra) # 80005fb0 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80004600:	00000493          	li	s1,0
    80004604:	00300793          	li	a5,3
    80004608:	0297c663          	blt	a5,s1,80004634 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    8000460c:	00349793          	slli	a5,s1,0x3
    80004610:	fe040713          	addi	a4,s0,-32
    80004614:	00f707b3          	add	a5,a4,a5
    80004618:	fe07b503          	ld	a0,-32(a5)
    8000461c:	ffffe097          	auipc	ra,0xffffe
    80004620:	8fc080e7          	jalr	-1796(ra) # 80001f18 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80004624:	0014849b          	addiw	s1,s1,1
    80004628:	fddff06f          	j	80004604 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    8000462c:	ffffe097          	auipc	ra,0xffffe
    80004630:	94c080e7          	jalr	-1716(ra) # 80001f78 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004634:	00008797          	auipc	a5,0x8
    80004638:	7047c783          	lbu	a5,1796(a5) # 8000cd38 <_ZL9finishedA>
    8000463c:	fe0788e3          	beqz	a5,8000462c <_Z20Threads_CPP_API_testv+0x124>
    80004640:	00008797          	auipc	a5,0x8
    80004644:	6f97c783          	lbu	a5,1785(a5) # 8000cd39 <_ZL9finishedB>
    80004648:	fe0782e3          	beqz	a5,8000462c <_Z20Threads_CPP_API_testv+0x124>
    8000464c:	00008797          	auipc	a5,0x8
    80004650:	6ee7c783          	lbu	a5,1774(a5) # 8000cd3a <_ZL9finishedC>
    80004654:	fc078ce3          	beqz	a5,8000462c <_Z20Threads_CPP_API_testv+0x124>
    80004658:	00008797          	auipc	a5,0x8
    8000465c:	6e37c783          	lbu	a5,1763(a5) # 8000cd3b <_ZL9finishedD>
    80004660:	fc0786e3          	beqz	a5,8000462c <_Z20Threads_CPP_API_testv+0x124>
    80004664:	fc040493          	addi	s1,s0,-64
    80004668:	0080006f          	j	80004670 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    8000466c:	00848493          	addi	s1,s1,8
    80004670:	fe040793          	addi	a5,s0,-32
    80004674:	08f48663          	beq	s1,a5,80004700 <_Z20Threads_CPP_API_testv+0x1f8>
    80004678:	0004b503          	ld	a0,0(s1)
    8000467c:	fe0508e3          	beqz	a0,8000466c <_Z20Threads_CPP_API_testv+0x164>
    80004680:	00053783          	ld	a5,0(a0)
    80004684:	0087b783          	ld	a5,8(a5)
    80004688:	000780e7          	jalr	a5
    8000468c:	fe1ff06f          	j	8000466c <_Z20Threads_CPP_API_testv+0x164>
    80004690:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80004694:	00048513          	mv	a0,s1
    80004698:	ffffd097          	auipc	ra,0xffffd
    8000469c:	780080e7          	jalr	1920(ra) # 80001e18 <_ZdlPv>
    800046a0:	00090513          	mv	a0,s2
    800046a4:	00009097          	auipc	ra,0x9
    800046a8:	7a4080e7          	jalr	1956(ra) # 8000de48 <_Unwind_Resume>
    800046ac:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    800046b0:	00048513          	mv	a0,s1
    800046b4:	ffffd097          	auipc	ra,0xffffd
    800046b8:	764080e7          	jalr	1892(ra) # 80001e18 <_ZdlPv>
    800046bc:	00090513          	mv	a0,s2
    800046c0:	00009097          	auipc	ra,0x9
    800046c4:	788080e7          	jalr	1928(ra) # 8000de48 <_Unwind_Resume>
    800046c8:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    800046cc:	00048513          	mv	a0,s1
    800046d0:	ffffd097          	auipc	ra,0xffffd
    800046d4:	748080e7          	jalr	1864(ra) # 80001e18 <_ZdlPv>
    800046d8:	00090513          	mv	a0,s2
    800046dc:	00009097          	auipc	ra,0x9
    800046e0:	76c080e7          	jalr	1900(ra) # 8000de48 <_Unwind_Resume>
    800046e4:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    800046e8:	00048513          	mv	a0,s1
    800046ec:	ffffd097          	auipc	ra,0xffffd
    800046f0:	72c080e7          	jalr	1836(ra) # 80001e18 <_ZdlPv>
    800046f4:	00090513          	mv	a0,s2
    800046f8:	00009097          	auipc	ra,0x9
    800046fc:	750080e7          	jalr	1872(ra) # 8000de48 <_Unwind_Resume>
}
    80004700:	03813083          	ld	ra,56(sp)
    80004704:	03013403          	ld	s0,48(sp)
    80004708:	02813483          	ld	s1,40(sp)
    8000470c:	02013903          	ld	s2,32(sp)
    80004710:	04010113          	addi	sp,sp,64
    80004714:	00008067          	ret

0000000080004718 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80004718:	ff010113          	addi	sp,sp,-16
    8000471c:	00113423          	sd	ra,8(sp)
    80004720:	00813023          	sd	s0,0(sp)
    80004724:	01010413          	addi	s0,sp,16
    80004728:	00008797          	auipc	a5,0x8
    8000472c:	33078793          	addi	a5,a5,816 # 8000ca58 <_ZTV7WorkerA+0x10>
    80004730:	00f53023          	sd	a5,0(a0)
    80004734:	ffffd097          	auipc	ra,0xffffd
    80004738:	5ec080e7          	jalr	1516(ra) # 80001d20 <_ZN6ThreadD1Ev>
    8000473c:	00813083          	ld	ra,8(sp)
    80004740:	00013403          	ld	s0,0(sp)
    80004744:	01010113          	addi	sp,sp,16
    80004748:	00008067          	ret

000000008000474c <_ZN7WorkerAD0Ev>:
    8000474c:	fe010113          	addi	sp,sp,-32
    80004750:	00113c23          	sd	ra,24(sp)
    80004754:	00813823          	sd	s0,16(sp)
    80004758:	00913423          	sd	s1,8(sp)
    8000475c:	02010413          	addi	s0,sp,32
    80004760:	00050493          	mv	s1,a0
    80004764:	00008797          	auipc	a5,0x8
    80004768:	2f478793          	addi	a5,a5,756 # 8000ca58 <_ZTV7WorkerA+0x10>
    8000476c:	00f53023          	sd	a5,0(a0)
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	5b0080e7          	jalr	1456(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004778:	00048513          	mv	a0,s1
    8000477c:	ffffd097          	auipc	ra,0xffffd
    80004780:	69c080e7          	jalr	1692(ra) # 80001e18 <_ZdlPv>
    80004784:	01813083          	ld	ra,24(sp)
    80004788:	01013403          	ld	s0,16(sp)
    8000478c:	00813483          	ld	s1,8(sp)
    80004790:	02010113          	addi	sp,sp,32
    80004794:	00008067          	ret

0000000080004798 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80004798:	ff010113          	addi	sp,sp,-16
    8000479c:	00113423          	sd	ra,8(sp)
    800047a0:	00813023          	sd	s0,0(sp)
    800047a4:	01010413          	addi	s0,sp,16
    800047a8:	00008797          	auipc	a5,0x8
    800047ac:	2d878793          	addi	a5,a5,728 # 8000ca80 <_ZTV7WorkerB+0x10>
    800047b0:	00f53023          	sd	a5,0(a0)
    800047b4:	ffffd097          	auipc	ra,0xffffd
    800047b8:	56c080e7          	jalr	1388(ra) # 80001d20 <_ZN6ThreadD1Ev>
    800047bc:	00813083          	ld	ra,8(sp)
    800047c0:	00013403          	ld	s0,0(sp)
    800047c4:	01010113          	addi	sp,sp,16
    800047c8:	00008067          	ret

00000000800047cc <_ZN7WorkerBD0Ev>:
    800047cc:	fe010113          	addi	sp,sp,-32
    800047d0:	00113c23          	sd	ra,24(sp)
    800047d4:	00813823          	sd	s0,16(sp)
    800047d8:	00913423          	sd	s1,8(sp)
    800047dc:	02010413          	addi	s0,sp,32
    800047e0:	00050493          	mv	s1,a0
    800047e4:	00008797          	auipc	a5,0x8
    800047e8:	29c78793          	addi	a5,a5,668 # 8000ca80 <_ZTV7WorkerB+0x10>
    800047ec:	00f53023          	sd	a5,0(a0)
    800047f0:	ffffd097          	auipc	ra,0xffffd
    800047f4:	530080e7          	jalr	1328(ra) # 80001d20 <_ZN6ThreadD1Ev>
    800047f8:	00048513          	mv	a0,s1
    800047fc:	ffffd097          	auipc	ra,0xffffd
    80004800:	61c080e7          	jalr	1564(ra) # 80001e18 <_ZdlPv>
    80004804:	01813083          	ld	ra,24(sp)
    80004808:	01013403          	ld	s0,16(sp)
    8000480c:	00813483          	ld	s1,8(sp)
    80004810:	02010113          	addi	sp,sp,32
    80004814:	00008067          	ret

0000000080004818 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80004818:	ff010113          	addi	sp,sp,-16
    8000481c:	00113423          	sd	ra,8(sp)
    80004820:	00813023          	sd	s0,0(sp)
    80004824:	01010413          	addi	s0,sp,16
    80004828:	00008797          	auipc	a5,0x8
    8000482c:	28078793          	addi	a5,a5,640 # 8000caa8 <_ZTV7WorkerC+0x10>
    80004830:	00f53023          	sd	a5,0(a0)
    80004834:	ffffd097          	auipc	ra,0xffffd
    80004838:	4ec080e7          	jalr	1260(ra) # 80001d20 <_ZN6ThreadD1Ev>
    8000483c:	00813083          	ld	ra,8(sp)
    80004840:	00013403          	ld	s0,0(sp)
    80004844:	01010113          	addi	sp,sp,16
    80004848:	00008067          	ret

000000008000484c <_ZN7WorkerCD0Ev>:
    8000484c:	fe010113          	addi	sp,sp,-32
    80004850:	00113c23          	sd	ra,24(sp)
    80004854:	00813823          	sd	s0,16(sp)
    80004858:	00913423          	sd	s1,8(sp)
    8000485c:	02010413          	addi	s0,sp,32
    80004860:	00050493          	mv	s1,a0
    80004864:	00008797          	auipc	a5,0x8
    80004868:	24478793          	addi	a5,a5,580 # 8000caa8 <_ZTV7WorkerC+0x10>
    8000486c:	00f53023          	sd	a5,0(a0)
    80004870:	ffffd097          	auipc	ra,0xffffd
    80004874:	4b0080e7          	jalr	1200(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004878:	00048513          	mv	a0,s1
    8000487c:	ffffd097          	auipc	ra,0xffffd
    80004880:	59c080e7          	jalr	1436(ra) # 80001e18 <_ZdlPv>
    80004884:	01813083          	ld	ra,24(sp)
    80004888:	01013403          	ld	s0,16(sp)
    8000488c:	00813483          	ld	s1,8(sp)
    80004890:	02010113          	addi	sp,sp,32
    80004894:	00008067          	ret

0000000080004898 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80004898:	ff010113          	addi	sp,sp,-16
    8000489c:	00113423          	sd	ra,8(sp)
    800048a0:	00813023          	sd	s0,0(sp)
    800048a4:	01010413          	addi	s0,sp,16
    800048a8:	00008797          	auipc	a5,0x8
    800048ac:	22878793          	addi	a5,a5,552 # 8000cad0 <_ZTV7WorkerD+0x10>
    800048b0:	00f53023          	sd	a5,0(a0)
    800048b4:	ffffd097          	auipc	ra,0xffffd
    800048b8:	46c080e7          	jalr	1132(ra) # 80001d20 <_ZN6ThreadD1Ev>
    800048bc:	00813083          	ld	ra,8(sp)
    800048c0:	00013403          	ld	s0,0(sp)
    800048c4:	01010113          	addi	sp,sp,16
    800048c8:	00008067          	ret

00000000800048cc <_ZN7WorkerDD0Ev>:
    800048cc:	fe010113          	addi	sp,sp,-32
    800048d0:	00113c23          	sd	ra,24(sp)
    800048d4:	00813823          	sd	s0,16(sp)
    800048d8:	00913423          	sd	s1,8(sp)
    800048dc:	02010413          	addi	s0,sp,32
    800048e0:	00050493          	mv	s1,a0
    800048e4:	00008797          	auipc	a5,0x8
    800048e8:	1ec78793          	addi	a5,a5,492 # 8000cad0 <_ZTV7WorkerD+0x10>
    800048ec:	00f53023          	sd	a5,0(a0)
    800048f0:	ffffd097          	auipc	ra,0xffffd
    800048f4:	430080e7          	jalr	1072(ra) # 80001d20 <_ZN6ThreadD1Ev>
    800048f8:	00048513          	mv	a0,s1
    800048fc:	ffffd097          	auipc	ra,0xffffd
    80004900:	51c080e7          	jalr	1308(ra) # 80001e18 <_ZdlPv>
    80004904:	01813083          	ld	ra,24(sp)
    80004908:	01013403          	ld	s0,16(sp)
    8000490c:	00813483          	ld	s1,8(sp)
    80004910:	02010113          	addi	sp,sp,32
    80004914:	00008067          	ret

0000000080004918 <_ZN7WorkerA3runEv>:
    void run() override {
    80004918:	ff010113          	addi	sp,sp,-16
    8000491c:	00113423          	sd	ra,8(sp)
    80004920:	00813023          	sd	s0,0(sp)
    80004924:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80004928:	00000593          	li	a1,0
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	774080e7          	jalr	1908(ra) # 800040a0 <_ZN7WorkerA11workerBodyAEPv>
    }
    80004934:	00813083          	ld	ra,8(sp)
    80004938:	00013403          	ld	s0,0(sp)
    8000493c:	01010113          	addi	sp,sp,16
    80004940:	00008067          	ret

0000000080004944 <_ZN7WorkerB3runEv>:
    void run() override {
    80004944:	ff010113          	addi	sp,sp,-16
    80004948:	00113423          	sd	ra,8(sp)
    8000494c:	00813023          	sd	s0,0(sp)
    80004950:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80004954:	00000593          	li	a1,0
    80004958:	00000097          	auipc	ra,0x0
    8000495c:	814080e7          	jalr	-2028(ra) # 8000416c <_ZN7WorkerB11workerBodyBEPv>
    }
    80004960:	00813083          	ld	ra,8(sp)
    80004964:	00013403          	ld	s0,0(sp)
    80004968:	01010113          	addi	sp,sp,16
    8000496c:	00008067          	ret

0000000080004970 <_ZN7WorkerC3runEv>:
    void run() override {
    80004970:	ff010113          	addi	sp,sp,-16
    80004974:	00113423          	sd	ra,8(sp)
    80004978:	00813023          	sd	s0,0(sp)
    8000497c:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80004980:	00000593          	li	a1,0
    80004984:	00000097          	auipc	ra,0x0
    80004988:	8bc080e7          	jalr	-1860(ra) # 80004240 <_ZN7WorkerC11workerBodyCEPv>
    }
    8000498c:	00813083          	ld	ra,8(sp)
    80004990:	00013403          	ld	s0,0(sp)
    80004994:	01010113          	addi	sp,sp,16
    80004998:	00008067          	ret

000000008000499c <_ZN7WorkerD3runEv>:
    void run() override {
    8000499c:	ff010113          	addi	sp,sp,-16
    800049a0:	00113423          	sd	ra,8(sp)
    800049a4:	00813023          	sd	s0,0(sp)
    800049a8:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800049ac:	00000593          	li	a1,0
    800049b0:	00000097          	auipc	ra,0x0
    800049b4:	a10080e7          	jalr	-1520(ra) # 800043c0 <_ZN7WorkerD11workerBodyDEPv>
    }
    800049b8:	00813083          	ld	ra,8(sp)
    800049bc:	00013403          	ld	s0,0(sp)
    800049c0:	01010113          	addi	sp,sp,16
    800049c4:	00008067          	ret

00000000800049c8 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800049c8:	f8010113          	addi	sp,sp,-128
    800049cc:	06113c23          	sd	ra,120(sp)
    800049d0:	06813823          	sd	s0,112(sp)
    800049d4:	06913423          	sd	s1,104(sp)
    800049d8:	07213023          	sd	s2,96(sp)
    800049dc:	05313c23          	sd	s3,88(sp)
    800049e0:	05413823          	sd	s4,80(sp)
    800049e4:	05513423          	sd	s5,72(sp)
    800049e8:	05613023          	sd	s6,64(sp)
    800049ec:	03713c23          	sd	s7,56(sp)
    800049f0:	03813823          	sd	s8,48(sp)
    800049f4:	03913423          	sd	s9,40(sp)
    800049f8:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    800049fc:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80004a00:	00005517          	auipc	a0,0x5
    80004a04:	6b050513          	addi	a0,a0,1712 # 8000a0b0 <CONSOLE_STATUS+0xa0>
    80004a08:	00001097          	auipc	ra,0x1
    80004a0c:	5a8080e7          	jalr	1448(ra) # 80005fb0 <_Z11printStringPKc>
    getString(input, 30);
    80004a10:	01e00593          	li	a1,30
    80004a14:	f8040493          	addi	s1,s0,-128
    80004a18:	00048513          	mv	a0,s1
    80004a1c:	00001097          	auipc	ra,0x1
    80004a20:	61c080e7          	jalr	1564(ra) # 80006038 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004a24:	00048513          	mv	a0,s1
    80004a28:	00001097          	auipc	ra,0x1
    80004a2c:	6e8080e7          	jalr	1768(ra) # 80006110 <_Z11stringToIntPKc>
    80004a30:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80004a34:	00005517          	auipc	a0,0x5
    80004a38:	69c50513          	addi	a0,a0,1692 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    80004a3c:	00001097          	auipc	ra,0x1
    80004a40:	574080e7          	jalr	1396(ra) # 80005fb0 <_Z11printStringPKc>
    getString(input, 30);
    80004a44:	01e00593          	li	a1,30
    80004a48:	00048513          	mv	a0,s1
    80004a4c:	00001097          	auipc	ra,0x1
    80004a50:	5ec080e7          	jalr	1516(ra) # 80006038 <_Z9getStringPci>
    n = stringToInt(input);
    80004a54:	00048513          	mv	a0,s1
    80004a58:	00001097          	auipc	ra,0x1
    80004a5c:	6b8080e7          	jalr	1720(ra) # 80006110 <_Z11stringToIntPKc>
    80004a60:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80004a64:	00005517          	auipc	a0,0x5
    80004a68:	68c50513          	addi	a0,a0,1676 # 8000a0f0 <CONSOLE_STATUS+0xe0>
    80004a6c:	00001097          	auipc	ra,0x1
    80004a70:	544080e7          	jalr	1348(ra) # 80005fb0 <_Z11printStringPKc>
    printInt(threadNum);
    80004a74:	00000613          	li	a2,0
    80004a78:	00a00593          	li	a1,10
    80004a7c:	00098513          	mv	a0,s3
    80004a80:	00001097          	auipc	ra,0x1
    80004a84:	6e0080e7          	jalr	1760(ra) # 80006160 <_Z8printIntiii>
    printString(" i velicina bafera ");
    80004a88:	00005517          	auipc	a0,0x5
    80004a8c:	68050513          	addi	a0,a0,1664 # 8000a108 <CONSOLE_STATUS+0xf8>
    80004a90:	00001097          	auipc	ra,0x1
    80004a94:	520080e7          	jalr	1312(ra) # 80005fb0 <_Z11printStringPKc>
    printInt(n);
    80004a98:	00000613          	li	a2,0
    80004a9c:	00a00593          	li	a1,10
    80004aa0:	00048513          	mv	a0,s1
    80004aa4:	00001097          	auipc	ra,0x1
    80004aa8:	6bc080e7          	jalr	1724(ra) # 80006160 <_Z8printIntiii>
    printString(".\n");
    80004aac:	00005517          	auipc	a0,0x5
    80004ab0:	67450513          	addi	a0,a0,1652 # 8000a120 <CONSOLE_STATUS+0x110>
    80004ab4:	00001097          	auipc	ra,0x1
    80004ab8:	4fc080e7          	jalr	1276(ra) # 80005fb0 <_Z11printStringPKc>
    if (threadNum > n) {
    80004abc:	0334c463          	blt	s1,s3,80004ae4 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    80004ac0:	03305c63          	blez	s3,80004af8 <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80004ac4:	03800513          	li	a0,56
    80004ac8:	ffffd097          	auipc	ra,0xffffd
    80004acc:	300080e7          	jalr	768(ra) # 80001dc8 <_Znwm>
    80004ad0:	00050a93          	mv	s5,a0
    80004ad4:	00048593          	mv	a1,s1
    80004ad8:	00001097          	auipc	ra,0x1
    80004adc:	7a8080e7          	jalr	1960(ra) # 80006280 <_ZN9BufferCPPC1Ei>
    80004ae0:	0300006f          	j	80004b10 <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004ae4:	00005517          	auipc	a0,0x5
    80004ae8:	64450513          	addi	a0,a0,1604 # 8000a128 <CONSOLE_STATUS+0x118>
    80004aec:	00001097          	auipc	ra,0x1
    80004af0:	4c4080e7          	jalr	1220(ra) # 80005fb0 <_Z11printStringPKc>
        return;
    80004af4:	0140006f          	j	80004b08 <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004af8:	00005517          	auipc	a0,0x5
    80004afc:	67050513          	addi	a0,a0,1648 # 8000a168 <CONSOLE_STATUS+0x158>
    80004b00:	00001097          	auipc	ra,0x1
    80004b04:	4b0080e7          	jalr	1200(ra) # 80005fb0 <_Z11printStringPKc>
        return;
    80004b08:	000c0113          	mv	sp,s8
    80004b0c:	2140006f          	j	80004d20 <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    80004b10:	01000513          	li	a0,16
    80004b14:	ffffd097          	auipc	ra,0xffffd
    80004b18:	2b4080e7          	jalr	692(ra) # 80001dc8 <_Znwm>
    80004b1c:	00050913          	mv	s2,a0
    80004b20:	00000593          	li	a1,0
    80004b24:	ffffd097          	auipc	ra,0xffffd
    80004b28:	584080e7          	jalr	1412(ra) # 800020a8 <_ZN9SemaphoreC1Ej>
    80004b2c:	00008797          	auipc	a5,0x8
    80004b30:	2127be23          	sd	s2,540(a5) # 8000cd48 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80004b34:	00399793          	slli	a5,s3,0x3
    80004b38:	00f78793          	addi	a5,a5,15
    80004b3c:	ff07f793          	andi	a5,a5,-16
    80004b40:	40f10133          	sub	sp,sp,a5
    80004b44:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80004b48:	0019871b          	addiw	a4,s3,1
    80004b4c:	00171793          	slli	a5,a4,0x1
    80004b50:	00e787b3          	add	a5,a5,a4
    80004b54:	00379793          	slli	a5,a5,0x3
    80004b58:	00f78793          	addi	a5,a5,15
    80004b5c:	ff07f793          	andi	a5,a5,-16
    80004b60:	40f10133          	sub	sp,sp,a5
    80004b64:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    80004b68:	00199493          	slli	s1,s3,0x1
    80004b6c:	013484b3          	add	s1,s1,s3
    80004b70:	00349493          	slli	s1,s1,0x3
    80004b74:	009b04b3          	add	s1,s6,s1
    80004b78:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80004b7c:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80004b80:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80004b84:	02800513          	li	a0,40
    80004b88:	ffffd097          	auipc	ra,0xffffd
    80004b8c:	240080e7          	jalr	576(ra) # 80001dc8 <_Znwm>
    80004b90:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80004b94:	ffffd097          	auipc	ra,0xffffd
    80004b98:	434080e7          	jalr	1076(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80004b9c:	00008797          	auipc	a5,0x8
    80004ba0:	fac78793          	addi	a5,a5,-84 # 8000cb48 <_ZTV8Consumer+0x10>
    80004ba4:	00fbb023          	sd	a5,0(s7)
    80004ba8:	029bb023          	sd	s1,32(s7)
    consumer->start();
    80004bac:	000b8513          	mv	a0,s7
    80004bb0:	ffffd097          	auipc	ra,0xffffd
    80004bb4:	368080e7          	jalr	872(ra) # 80001f18 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    80004bb8:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80004bbc:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80004bc0:	00008797          	auipc	a5,0x8
    80004bc4:	1887b783          	ld	a5,392(a5) # 8000cd48 <_ZL10waitForAll>
    80004bc8:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80004bcc:	02800513          	li	a0,40
    80004bd0:	ffffd097          	auipc	ra,0xffffd
    80004bd4:	1f8080e7          	jalr	504(ra) # 80001dc8 <_Znwm>
    80004bd8:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80004bdc:	ffffd097          	auipc	ra,0xffffd
    80004be0:	3ec080e7          	jalr	1004(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80004be4:	00008797          	auipc	a5,0x8
    80004be8:	f1478793          	addi	a5,a5,-236 # 8000caf8 <_ZTV16ProducerKeyborad+0x10>
    80004bec:	00f4b023          	sd	a5,0(s1)
    80004bf0:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80004bf4:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    80004bf8:	00048513          	mv	a0,s1
    80004bfc:	ffffd097          	auipc	ra,0xffffd
    80004c00:	31c080e7          	jalr	796(ra) # 80001f18 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80004c04:	00100913          	li	s2,1
    80004c08:	0300006f          	j	80004c38 <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80004c0c:	00008797          	auipc	a5,0x8
    80004c10:	f1478793          	addi	a5,a5,-236 # 8000cb20 <_ZTV8Producer+0x10>
    80004c14:	00fcb023          	sd	a5,0(s9)
    80004c18:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80004c1c:	00391793          	slli	a5,s2,0x3
    80004c20:	00fa07b3          	add	a5,s4,a5
    80004c24:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    80004c28:	000c8513          	mv	a0,s9
    80004c2c:	ffffd097          	auipc	ra,0xffffd
    80004c30:	2ec080e7          	jalr	748(ra) # 80001f18 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80004c34:	0019091b          	addiw	s2,s2,1
    80004c38:	05395263          	bge	s2,s3,80004c7c <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    80004c3c:	00191493          	slli	s1,s2,0x1
    80004c40:	012484b3          	add	s1,s1,s2
    80004c44:	00349493          	slli	s1,s1,0x3
    80004c48:	009b04b3          	add	s1,s6,s1
    80004c4c:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80004c50:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80004c54:	00008797          	auipc	a5,0x8
    80004c58:	0f47b783          	ld	a5,244(a5) # 8000cd48 <_ZL10waitForAll>
    80004c5c:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80004c60:	02800513          	li	a0,40
    80004c64:	ffffd097          	auipc	ra,0xffffd
    80004c68:	164080e7          	jalr	356(ra) # 80001dc8 <_Znwm>
    80004c6c:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80004c70:	ffffd097          	auipc	ra,0xffffd
    80004c74:	358080e7          	jalr	856(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80004c78:	f95ff06f          	j	80004c0c <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    80004c7c:	ffffd097          	auipc	ra,0xffffd
    80004c80:	2fc080e7          	jalr	764(ra) # 80001f78 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80004c84:	00000493          	li	s1,0
    80004c88:	0099ce63          	blt	s3,s1,80004ca4 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    80004c8c:	00008517          	auipc	a0,0x8
    80004c90:	0bc53503          	ld	a0,188(a0) # 8000cd48 <_ZL10waitForAll>
    80004c94:	ffffd097          	auipc	ra,0xffffd
    80004c98:	3bc080e7          	jalr	956(ra) # 80002050 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80004c9c:	0014849b          	addiw	s1,s1,1
    80004ca0:	fe9ff06f          	j	80004c88 <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    80004ca4:	00008517          	auipc	a0,0x8
    80004ca8:	0a453503          	ld	a0,164(a0) # 8000cd48 <_ZL10waitForAll>
    80004cac:	00050863          	beqz	a0,80004cbc <_Z20testConsumerProducerv+0x2f4>
    80004cb0:	00053783          	ld	a5,0(a0)
    80004cb4:	0087b783          	ld	a5,8(a5)
    80004cb8:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80004cbc:	00000493          	li	s1,0
    80004cc0:	0080006f          	j	80004cc8 <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    80004cc4:	0014849b          	addiw	s1,s1,1
    80004cc8:	0334d263          	bge	s1,s3,80004cec <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    80004ccc:	00349793          	slli	a5,s1,0x3
    80004cd0:	00fa07b3          	add	a5,s4,a5
    80004cd4:	0007b503          	ld	a0,0(a5)
    80004cd8:	fe0506e3          	beqz	a0,80004cc4 <_Z20testConsumerProducerv+0x2fc>
    80004cdc:	00053783          	ld	a5,0(a0)
    80004ce0:	0087b783          	ld	a5,8(a5)
    80004ce4:	000780e7          	jalr	a5
    80004ce8:	fddff06f          	j	80004cc4 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    80004cec:	000b8a63          	beqz	s7,80004d00 <_Z20testConsumerProducerv+0x338>
    80004cf0:	000bb783          	ld	a5,0(s7)
    80004cf4:	0087b783          	ld	a5,8(a5)
    80004cf8:	000b8513          	mv	a0,s7
    80004cfc:	000780e7          	jalr	a5
    delete buffer;
    80004d00:	000a8e63          	beqz	s5,80004d1c <_Z20testConsumerProducerv+0x354>
    80004d04:	000a8513          	mv	a0,s5
    80004d08:	00002097          	auipc	ra,0x2
    80004d0c:	870080e7          	jalr	-1936(ra) # 80006578 <_ZN9BufferCPPD1Ev>
    80004d10:	000a8513          	mv	a0,s5
    80004d14:	ffffd097          	auipc	ra,0xffffd
    80004d18:	104080e7          	jalr	260(ra) # 80001e18 <_ZdlPv>
    80004d1c:	000c0113          	mv	sp,s8
}
    80004d20:	f8040113          	addi	sp,s0,-128
    80004d24:	07813083          	ld	ra,120(sp)
    80004d28:	07013403          	ld	s0,112(sp)
    80004d2c:	06813483          	ld	s1,104(sp)
    80004d30:	06013903          	ld	s2,96(sp)
    80004d34:	05813983          	ld	s3,88(sp)
    80004d38:	05013a03          	ld	s4,80(sp)
    80004d3c:	04813a83          	ld	s5,72(sp)
    80004d40:	04013b03          	ld	s6,64(sp)
    80004d44:	03813b83          	ld	s7,56(sp)
    80004d48:	03013c03          	ld	s8,48(sp)
    80004d4c:	02813c83          	ld	s9,40(sp)
    80004d50:	08010113          	addi	sp,sp,128
    80004d54:	00008067          	ret
    80004d58:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80004d5c:	000a8513          	mv	a0,s5
    80004d60:	ffffd097          	auipc	ra,0xffffd
    80004d64:	0b8080e7          	jalr	184(ra) # 80001e18 <_ZdlPv>
    80004d68:	00048513          	mv	a0,s1
    80004d6c:	00009097          	auipc	ra,0x9
    80004d70:	0dc080e7          	jalr	220(ra) # 8000de48 <_Unwind_Resume>
    80004d74:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80004d78:	00090513          	mv	a0,s2
    80004d7c:	ffffd097          	auipc	ra,0xffffd
    80004d80:	09c080e7          	jalr	156(ra) # 80001e18 <_ZdlPv>
    80004d84:	00048513          	mv	a0,s1
    80004d88:	00009097          	auipc	ra,0x9
    80004d8c:	0c0080e7          	jalr	192(ra) # 8000de48 <_Unwind_Resume>
    80004d90:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80004d94:	000b8513          	mv	a0,s7
    80004d98:	ffffd097          	auipc	ra,0xffffd
    80004d9c:	080080e7          	jalr	128(ra) # 80001e18 <_ZdlPv>
    80004da0:	00048513          	mv	a0,s1
    80004da4:	00009097          	auipc	ra,0x9
    80004da8:	0a4080e7          	jalr	164(ra) # 8000de48 <_Unwind_Resume>
    80004dac:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80004db0:	00048513          	mv	a0,s1
    80004db4:	ffffd097          	auipc	ra,0xffffd
    80004db8:	064080e7          	jalr	100(ra) # 80001e18 <_ZdlPv>
    80004dbc:	00090513          	mv	a0,s2
    80004dc0:	00009097          	auipc	ra,0x9
    80004dc4:	088080e7          	jalr	136(ra) # 8000de48 <_Unwind_Resume>
    80004dc8:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80004dcc:	000c8513          	mv	a0,s9
    80004dd0:	ffffd097          	auipc	ra,0xffffd
    80004dd4:	048080e7          	jalr	72(ra) # 80001e18 <_ZdlPv>
    80004dd8:	00048513          	mv	a0,s1
    80004ddc:	00009097          	auipc	ra,0x9
    80004de0:	06c080e7          	jalr	108(ra) # 8000de48 <_Unwind_Resume>

0000000080004de4 <_ZN8Consumer3runEv>:
    void run() override {
    80004de4:	fd010113          	addi	sp,sp,-48
    80004de8:	02113423          	sd	ra,40(sp)
    80004dec:	02813023          	sd	s0,32(sp)
    80004df0:	00913c23          	sd	s1,24(sp)
    80004df4:	01213823          	sd	s2,16(sp)
    80004df8:	01313423          	sd	s3,8(sp)
    80004dfc:	03010413          	addi	s0,sp,48
    80004e00:	00050913          	mv	s2,a0
        int i = 0;
    80004e04:	00000993          	li	s3,0
    80004e08:	0100006f          	j	80004e18 <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80004e0c:	00a00513          	li	a0,10
    80004e10:	ffffd097          	auipc	ra,0xffffd
    80004e14:	218080e7          	jalr	536(ra) # 80002028 <_ZN7Console4putcEc>
        while (!threadEnd) {
    80004e18:	00008797          	auipc	a5,0x8
    80004e1c:	f287a783          	lw	a5,-216(a5) # 8000cd40 <_ZL9threadEnd>
    80004e20:	04079a63          	bnez	a5,80004e74 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80004e24:	02093783          	ld	a5,32(s2)
    80004e28:	0087b503          	ld	a0,8(a5)
    80004e2c:	00001097          	auipc	ra,0x1
    80004e30:	638080e7          	jalr	1592(ra) # 80006464 <_ZN9BufferCPP3getEv>
            i++;
    80004e34:	0019849b          	addiw	s1,s3,1
    80004e38:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80004e3c:	0ff57513          	andi	a0,a0,255
    80004e40:	ffffd097          	auipc	ra,0xffffd
    80004e44:	1e8080e7          	jalr	488(ra) # 80002028 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80004e48:	05000793          	li	a5,80
    80004e4c:	02f4e4bb          	remw	s1,s1,a5
    80004e50:	fc0494e3          	bnez	s1,80004e18 <_ZN8Consumer3runEv+0x34>
    80004e54:	fb9ff06f          	j	80004e0c <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80004e58:	02093783          	ld	a5,32(s2)
    80004e5c:	0087b503          	ld	a0,8(a5)
    80004e60:	00001097          	auipc	ra,0x1
    80004e64:	604080e7          	jalr	1540(ra) # 80006464 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    80004e68:	0ff57513          	andi	a0,a0,255
    80004e6c:	ffffd097          	auipc	ra,0xffffd
    80004e70:	1bc080e7          	jalr	444(ra) # 80002028 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    80004e74:	02093783          	ld	a5,32(s2)
    80004e78:	0087b503          	ld	a0,8(a5)
    80004e7c:	00001097          	auipc	ra,0x1
    80004e80:	674080e7          	jalr	1652(ra) # 800064f0 <_ZN9BufferCPP6getCntEv>
    80004e84:	fca04ae3          	bgtz	a0,80004e58 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80004e88:	02093783          	ld	a5,32(s2)
    80004e8c:	0107b503          	ld	a0,16(a5)
    80004e90:	ffffd097          	auipc	ra,0xffffd
    80004e94:	1ec080e7          	jalr	492(ra) # 8000207c <_ZN9Semaphore6signalEv>
    }
    80004e98:	02813083          	ld	ra,40(sp)
    80004e9c:	02013403          	ld	s0,32(sp)
    80004ea0:	01813483          	ld	s1,24(sp)
    80004ea4:	01013903          	ld	s2,16(sp)
    80004ea8:	00813983          	ld	s3,8(sp)
    80004eac:	03010113          	addi	sp,sp,48
    80004eb0:	00008067          	ret

0000000080004eb4 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80004eb4:	ff010113          	addi	sp,sp,-16
    80004eb8:	00113423          	sd	ra,8(sp)
    80004ebc:	00813023          	sd	s0,0(sp)
    80004ec0:	01010413          	addi	s0,sp,16
    80004ec4:	00008797          	auipc	a5,0x8
    80004ec8:	c8478793          	addi	a5,a5,-892 # 8000cb48 <_ZTV8Consumer+0x10>
    80004ecc:	00f53023          	sd	a5,0(a0)
    80004ed0:	ffffd097          	auipc	ra,0xffffd
    80004ed4:	e50080e7          	jalr	-432(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004ed8:	00813083          	ld	ra,8(sp)
    80004edc:	00013403          	ld	s0,0(sp)
    80004ee0:	01010113          	addi	sp,sp,16
    80004ee4:	00008067          	ret

0000000080004ee8 <_ZN8ConsumerD0Ev>:
    80004ee8:	fe010113          	addi	sp,sp,-32
    80004eec:	00113c23          	sd	ra,24(sp)
    80004ef0:	00813823          	sd	s0,16(sp)
    80004ef4:	00913423          	sd	s1,8(sp)
    80004ef8:	02010413          	addi	s0,sp,32
    80004efc:	00050493          	mv	s1,a0
    80004f00:	00008797          	auipc	a5,0x8
    80004f04:	c4878793          	addi	a5,a5,-952 # 8000cb48 <_ZTV8Consumer+0x10>
    80004f08:	00f53023          	sd	a5,0(a0)
    80004f0c:	ffffd097          	auipc	ra,0xffffd
    80004f10:	e14080e7          	jalr	-492(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004f14:	00048513          	mv	a0,s1
    80004f18:	ffffd097          	auipc	ra,0xffffd
    80004f1c:	f00080e7          	jalr	-256(ra) # 80001e18 <_ZdlPv>
    80004f20:	01813083          	ld	ra,24(sp)
    80004f24:	01013403          	ld	s0,16(sp)
    80004f28:	00813483          	ld	s1,8(sp)
    80004f2c:	02010113          	addi	sp,sp,32
    80004f30:	00008067          	ret

0000000080004f34 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80004f34:	ff010113          	addi	sp,sp,-16
    80004f38:	00113423          	sd	ra,8(sp)
    80004f3c:	00813023          	sd	s0,0(sp)
    80004f40:	01010413          	addi	s0,sp,16
    80004f44:	00008797          	auipc	a5,0x8
    80004f48:	bb478793          	addi	a5,a5,-1100 # 8000caf8 <_ZTV16ProducerKeyborad+0x10>
    80004f4c:	00f53023          	sd	a5,0(a0)
    80004f50:	ffffd097          	auipc	ra,0xffffd
    80004f54:	dd0080e7          	jalr	-560(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004f58:	00813083          	ld	ra,8(sp)
    80004f5c:	00013403          	ld	s0,0(sp)
    80004f60:	01010113          	addi	sp,sp,16
    80004f64:	00008067          	ret

0000000080004f68 <_ZN16ProducerKeyboradD0Ev>:
    80004f68:	fe010113          	addi	sp,sp,-32
    80004f6c:	00113c23          	sd	ra,24(sp)
    80004f70:	00813823          	sd	s0,16(sp)
    80004f74:	00913423          	sd	s1,8(sp)
    80004f78:	02010413          	addi	s0,sp,32
    80004f7c:	00050493          	mv	s1,a0
    80004f80:	00008797          	auipc	a5,0x8
    80004f84:	b7878793          	addi	a5,a5,-1160 # 8000caf8 <_ZTV16ProducerKeyborad+0x10>
    80004f88:	00f53023          	sd	a5,0(a0)
    80004f8c:	ffffd097          	auipc	ra,0xffffd
    80004f90:	d94080e7          	jalr	-620(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004f94:	00048513          	mv	a0,s1
    80004f98:	ffffd097          	auipc	ra,0xffffd
    80004f9c:	e80080e7          	jalr	-384(ra) # 80001e18 <_ZdlPv>
    80004fa0:	01813083          	ld	ra,24(sp)
    80004fa4:	01013403          	ld	s0,16(sp)
    80004fa8:	00813483          	ld	s1,8(sp)
    80004fac:	02010113          	addi	sp,sp,32
    80004fb0:	00008067          	ret

0000000080004fb4 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80004fb4:	ff010113          	addi	sp,sp,-16
    80004fb8:	00113423          	sd	ra,8(sp)
    80004fbc:	00813023          	sd	s0,0(sp)
    80004fc0:	01010413          	addi	s0,sp,16
    80004fc4:	00008797          	auipc	a5,0x8
    80004fc8:	b5c78793          	addi	a5,a5,-1188 # 8000cb20 <_ZTV8Producer+0x10>
    80004fcc:	00f53023          	sd	a5,0(a0)
    80004fd0:	ffffd097          	auipc	ra,0xffffd
    80004fd4:	d50080e7          	jalr	-688(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80004fd8:	00813083          	ld	ra,8(sp)
    80004fdc:	00013403          	ld	s0,0(sp)
    80004fe0:	01010113          	addi	sp,sp,16
    80004fe4:	00008067          	ret

0000000080004fe8 <_ZN8ProducerD0Ev>:
    80004fe8:	fe010113          	addi	sp,sp,-32
    80004fec:	00113c23          	sd	ra,24(sp)
    80004ff0:	00813823          	sd	s0,16(sp)
    80004ff4:	00913423          	sd	s1,8(sp)
    80004ff8:	02010413          	addi	s0,sp,32
    80004ffc:	00050493          	mv	s1,a0
    80005000:	00008797          	auipc	a5,0x8
    80005004:	b2078793          	addi	a5,a5,-1248 # 8000cb20 <_ZTV8Producer+0x10>
    80005008:	00f53023          	sd	a5,0(a0)
    8000500c:	ffffd097          	auipc	ra,0xffffd
    80005010:	d14080e7          	jalr	-748(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005014:	00048513          	mv	a0,s1
    80005018:	ffffd097          	auipc	ra,0xffffd
    8000501c:	e00080e7          	jalr	-512(ra) # 80001e18 <_ZdlPv>
    80005020:	01813083          	ld	ra,24(sp)
    80005024:	01013403          	ld	s0,16(sp)
    80005028:	00813483          	ld	s1,8(sp)
    8000502c:	02010113          	addi	sp,sp,32
    80005030:	00008067          	ret

0000000080005034 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80005034:	fe010113          	addi	sp,sp,-32
    80005038:	00113c23          	sd	ra,24(sp)
    8000503c:	00813823          	sd	s0,16(sp)
    80005040:	00913423          	sd	s1,8(sp)
    80005044:	02010413          	addi	s0,sp,32
    80005048:	00050493          	mv	s1,a0
        while ((key = getc()) != 0x1b) {
    8000504c:	ffffd097          	auipc	ra,0xffffd
    80005050:	814080e7          	jalr	-2028(ra) # 80001860 <_Z4getcv>
    80005054:	0005059b          	sext.w	a1,a0
    80005058:	01b00793          	li	a5,27
    8000505c:	00f58c63          	beq	a1,a5,80005074 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80005060:	0204b783          	ld	a5,32(s1)
    80005064:	0087b503          	ld	a0,8(a5)
    80005068:	00001097          	auipc	ra,0x1
    8000506c:	36c080e7          	jalr	876(ra) # 800063d4 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 0x1b) {
    80005070:	fddff06f          	j	8000504c <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80005074:	00100793          	li	a5,1
    80005078:	00008717          	auipc	a4,0x8
    8000507c:	ccf72423          	sw	a5,-824(a4) # 8000cd40 <_ZL9threadEnd>
        td->buffer->put('!');
    80005080:	0204b783          	ld	a5,32(s1)
    80005084:	02100593          	li	a1,33
    80005088:	0087b503          	ld	a0,8(a5)
    8000508c:	00001097          	auipc	ra,0x1
    80005090:	348080e7          	jalr	840(ra) # 800063d4 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80005094:	0204b783          	ld	a5,32(s1)
    80005098:	0107b503          	ld	a0,16(a5)
    8000509c:	ffffd097          	auipc	ra,0xffffd
    800050a0:	fe0080e7          	jalr	-32(ra) # 8000207c <_ZN9Semaphore6signalEv>
    }
    800050a4:	01813083          	ld	ra,24(sp)
    800050a8:	01013403          	ld	s0,16(sp)
    800050ac:	00813483          	ld	s1,8(sp)
    800050b0:	02010113          	addi	sp,sp,32
    800050b4:	00008067          	ret

00000000800050b8 <_ZN8Producer3runEv>:
    void run() override {
    800050b8:	fe010113          	addi	sp,sp,-32
    800050bc:	00113c23          	sd	ra,24(sp)
    800050c0:	00813823          	sd	s0,16(sp)
    800050c4:	00913423          	sd	s1,8(sp)
    800050c8:	01213023          	sd	s2,0(sp)
    800050cc:	02010413          	addi	s0,sp,32
    800050d0:	00050493          	mv	s1,a0
        int i = 0;
    800050d4:	00000913          	li	s2,0
        while (!threadEnd) {
    800050d8:	00008797          	auipc	a5,0x8
    800050dc:	c687a783          	lw	a5,-920(a5) # 8000cd40 <_ZL9threadEnd>
    800050e0:	04079263          	bnez	a5,80005124 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    800050e4:	0204b783          	ld	a5,32(s1)
    800050e8:	0007a583          	lw	a1,0(a5)
    800050ec:	0305859b          	addiw	a1,a1,48
    800050f0:	0087b503          	ld	a0,8(a5)
    800050f4:	00001097          	auipc	ra,0x1
    800050f8:	2e0080e7          	jalr	736(ra) # 800063d4 <_ZN9BufferCPP3putEi>
            i++;
    800050fc:	0019071b          	addiw	a4,s2,1
    80005100:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80005104:	0204b783          	ld	a5,32(s1)
    80005108:	0007a783          	lw	a5,0(a5)
    8000510c:	00e787bb          	addw	a5,a5,a4
    80005110:	00500513          	li	a0,5
    80005114:	02a7e53b          	remw	a0,a5,a0
    80005118:	ffffd097          	auipc	ra,0xffffd
    8000511c:	e88080e7          	jalr	-376(ra) # 80001fa0 <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    80005120:	fb9ff06f          	j	800050d8 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80005124:	0204b783          	ld	a5,32(s1)
    80005128:	0107b503          	ld	a0,16(a5)
    8000512c:	ffffd097          	auipc	ra,0xffffd
    80005130:	f50080e7          	jalr	-176(ra) # 8000207c <_ZN9Semaphore6signalEv>
    }
    80005134:	01813083          	ld	ra,24(sp)
    80005138:	01013403          	ld	s0,16(sp)
    8000513c:	00813483          	ld	s1,8(sp)
    80005140:	00013903          	ld	s2,0(sp)
    80005144:	02010113          	addi	sp,sp,32
    80005148:	00008067          	ret

000000008000514c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    8000514c:	fe010113          	addi	sp,sp,-32
    80005150:	00113c23          	sd	ra,24(sp)
    80005154:	00813823          	sd	s0,16(sp)
    80005158:	00913423          	sd	s1,8(sp)
    8000515c:	01213023          	sd	s2,0(sp)
    80005160:	02010413          	addi	s0,sp,32
    80005164:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005168:	00100793          	li	a5,1
    8000516c:	02a7f863          	bgeu	a5,a0,8000519c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005170:	00a00793          	li	a5,10
    80005174:	02f577b3          	remu	a5,a0,a5
    80005178:	02078e63          	beqz	a5,800051b4 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000517c:	fff48513          	addi	a0,s1,-1
    80005180:	00000097          	auipc	ra,0x0
    80005184:	fcc080e7          	jalr	-52(ra) # 8000514c <_ZL9fibonaccim>
    80005188:	00050913          	mv	s2,a0
    8000518c:	ffe48513          	addi	a0,s1,-2
    80005190:	00000097          	auipc	ra,0x0
    80005194:	fbc080e7          	jalr	-68(ra) # 8000514c <_ZL9fibonaccim>
    80005198:	00a90533          	add	a0,s2,a0
}
    8000519c:	01813083          	ld	ra,24(sp)
    800051a0:	01013403          	ld	s0,16(sp)
    800051a4:	00813483          	ld	s1,8(sp)
    800051a8:	00013903          	ld	s2,0(sp)
    800051ac:	02010113          	addi	sp,sp,32
    800051b0:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800051b4:	ffffc097          	auipc	ra,0xffffc
    800051b8:	534080e7          	jalr	1332(ra) # 800016e8 <_Z15thread_dispatchv>
    800051bc:	fc1ff06f          	j	8000517c <_ZL9fibonaccim+0x30>

00000000800051c0 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800051c0:	fe010113          	addi	sp,sp,-32
    800051c4:	00113c23          	sd	ra,24(sp)
    800051c8:	00813823          	sd	s0,16(sp)
    800051cc:	00913423          	sd	s1,8(sp)
    800051d0:	01213023          	sd	s2,0(sp)
    800051d4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800051d8:	00a00493          	li	s1,10
    800051dc:	0400006f          	j	8000521c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800051e0:	00005517          	auipc	a0,0x5
    800051e4:	01850513          	addi	a0,a0,24 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    800051e8:	00001097          	auipc	ra,0x1
    800051ec:	dc8080e7          	jalr	-568(ra) # 80005fb0 <_Z11printStringPKc>
    800051f0:	00000613          	li	a2,0
    800051f4:	00a00593          	li	a1,10
    800051f8:	00048513          	mv	a0,s1
    800051fc:	00001097          	auipc	ra,0x1
    80005200:	f64080e7          	jalr	-156(ra) # 80006160 <_Z8printIntiii>
    80005204:	00005517          	auipc	a0,0x5
    80005208:	1e450513          	addi	a0,a0,484 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000520c:	00001097          	auipc	ra,0x1
    80005210:	da4080e7          	jalr	-604(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005214:	0014849b          	addiw	s1,s1,1
    80005218:	0ff4f493          	andi	s1,s1,255
    8000521c:	00c00793          	li	a5,12
    80005220:	fc97f0e3          	bgeu	a5,s1,800051e0 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005224:	00005517          	auipc	a0,0x5
    80005228:	fdc50513          	addi	a0,a0,-36 # 8000a200 <CONSOLE_STATUS+0x1f0>
    8000522c:	00001097          	auipc	ra,0x1
    80005230:	d84080e7          	jalr	-636(ra) # 80005fb0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005234:	00500313          	li	t1,5
    thread_dispatch();
    80005238:	ffffc097          	auipc	ra,0xffffc
    8000523c:	4b0080e7          	jalr	1200(ra) # 800016e8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005240:	01000513          	li	a0,16
    80005244:	00000097          	auipc	ra,0x0
    80005248:	f08080e7          	jalr	-248(ra) # 8000514c <_ZL9fibonaccim>
    8000524c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005250:	00005517          	auipc	a0,0x5
    80005254:	fc050513          	addi	a0,a0,-64 # 8000a210 <CONSOLE_STATUS+0x200>
    80005258:	00001097          	auipc	ra,0x1
    8000525c:	d58080e7          	jalr	-680(ra) # 80005fb0 <_Z11printStringPKc>
    80005260:	00000613          	li	a2,0
    80005264:	00a00593          	li	a1,10
    80005268:	0009051b          	sext.w	a0,s2
    8000526c:	00001097          	auipc	ra,0x1
    80005270:	ef4080e7          	jalr	-268(ra) # 80006160 <_Z8printIntiii>
    80005274:	00005517          	auipc	a0,0x5
    80005278:	17450513          	addi	a0,a0,372 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000527c:	00001097          	auipc	ra,0x1
    80005280:	d34080e7          	jalr	-716(ra) # 80005fb0 <_Z11printStringPKc>
    80005284:	0400006f          	j	800052c4 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005288:	00005517          	auipc	a0,0x5
    8000528c:	f7050513          	addi	a0,a0,-144 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80005290:	00001097          	auipc	ra,0x1
    80005294:	d20080e7          	jalr	-736(ra) # 80005fb0 <_Z11printStringPKc>
    80005298:	00000613          	li	a2,0
    8000529c:	00a00593          	li	a1,10
    800052a0:	00048513          	mv	a0,s1
    800052a4:	00001097          	auipc	ra,0x1
    800052a8:	ebc080e7          	jalr	-324(ra) # 80006160 <_Z8printIntiii>
    800052ac:	00005517          	auipc	a0,0x5
    800052b0:	13c50513          	addi	a0,a0,316 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800052b4:	00001097          	auipc	ra,0x1
    800052b8:	cfc080e7          	jalr	-772(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800052bc:	0014849b          	addiw	s1,s1,1
    800052c0:	0ff4f493          	andi	s1,s1,255
    800052c4:	00f00793          	li	a5,15
    800052c8:	fc97f0e3          	bgeu	a5,s1,80005288 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800052cc:	00005517          	auipc	a0,0x5
    800052d0:	f5450513          	addi	a0,a0,-172 # 8000a220 <CONSOLE_STATUS+0x210>
    800052d4:	00001097          	auipc	ra,0x1
    800052d8:	cdc080e7          	jalr	-804(ra) # 80005fb0 <_Z11printStringPKc>
    finishedD = true;
    800052dc:	00100793          	li	a5,1
    800052e0:	00008717          	auipc	a4,0x8
    800052e4:	a6f70823          	sb	a5,-1424(a4) # 8000cd50 <_ZL9finishedD>
    thread_dispatch();
    800052e8:	ffffc097          	auipc	ra,0xffffc
    800052ec:	400080e7          	jalr	1024(ra) # 800016e8 <_Z15thread_dispatchv>
}
    800052f0:	01813083          	ld	ra,24(sp)
    800052f4:	01013403          	ld	s0,16(sp)
    800052f8:	00813483          	ld	s1,8(sp)
    800052fc:	00013903          	ld	s2,0(sp)
    80005300:	02010113          	addi	sp,sp,32
    80005304:	00008067          	ret

0000000080005308 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005308:	fe010113          	addi	sp,sp,-32
    8000530c:	00113c23          	sd	ra,24(sp)
    80005310:	00813823          	sd	s0,16(sp)
    80005314:	00913423          	sd	s1,8(sp)
    80005318:	01213023          	sd	s2,0(sp)
    8000531c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005320:	00000493          	li	s1,0
    80005324:	0400006f          	j	80005364 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005328:	00005517          	auipc	a0,0x5
    8000532c:	ea050513          	addi	a0,a0,-352 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80005330:	00001097          	auipc	ra,0x1
    80005334:	c80080e7          	jalr	-896(ra) # 80005fb0 <_Z11printStringPKc>
    80005338:	00000613          	li	a2,0
    8000533c:	00a00593          	li	a1,10
    80005340:	00048513          	mv	a0,s1
    80005344:	00001097          	auipc	ra,0x1
    80005348:	e1c080e7          	jalr	-484(ra) # 80006160 <_Z8printIntiii>
    8000534c:	00005517          	auipc	a0,0x5
    80005350:	09c50513          	addi	a0,a0,156 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80005354:	00001097          	auipc	ra,0x1
    80005358:	c5c080e7          	jalr	-932(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000535c:	0014849b          	addiw	s1,s1,1
    80005360:	0ff4f493          	andi	s1,s1,255
    80005364:	00200793          	li	a5,2
    80005368:	fc97f0e3          	bgeu	a5,s1,80005328 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    8000536c:	00005517          	auipc	a0,0x5
    80005370:	e6450513          	addi	a0,a0,-412 # 8000a1d0 <CONSOLE_STATUS+0x1c0>
    80005374:	00001097          	auipc	ra,0x1
    80005378:	c3c080e7          	jalr	-964(ra) # 80005fb0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000537c:	00700313          	li	t1,7
    thread_dispatch();
    80005380:	ffffc097          	auipc	ra,0xffffc
    80005384:	368080e7          	jalr	872(ra) # 800016e8 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005388:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    8000538c:	00005517          	auipc	a0,0x5
    80005390:	e5450513          	addi	a0,a0,-428 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    80005394:	00001097          	auipc	ra,0x1
    80005398:	c1c080e7          	jalr	-996(ra) # 80005fb0 <_Z11printStringPKc>
    8000539c:	00000613          	li	a2,0
    800053a0:	00a00593          	li	a1,10
    800053a4:	0009051b          	sext.w	a0,s2
    800053a8:	00001097          	auipc	ra,0x1
    800053ac:	db8080e7          	jalr	-584(ra) # 80006160 <_Z8printIntiii>
    800053b0:	00005517          	auipc	a0,0x5
    800053b4:	03850513          	addi	a0,a0,56 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800053b8:	00001097          	auipc	ra,0x1
    800053bc:	bf8080e7          	jalr	-1032(ra) # 80005fb0 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800053c0:	00c00513          	li	a0,12
    800053c4:	00000097          	auipc	ra,0x0
    800053c8:	d88080e7          	jalr	-632(ra) # 8000514c <_ZL9fibonaccim>
    800053cc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800053d0:	00005517          	auipc	a0,0x5
    800053d4:	e1850513          	addi	a0,a0,-488 # 8000a1e8 <CONSOLE_STATUS+0x1d8>
    800053d8:	00001097          	auipc	ra,0x1
    800053dc:	bd8080e7          	jalr	-1064(ra) # 80005fb0 <_Z11printStringPKc>
    800053e0:	00000613          	li	a2,0
    800053e4:	00a00593          	li	a1,10
    800053e8:	0009051b          	sext.w	a0,s2
    800053ec:	00001097          	auipc	ra,0x1
    800053f0:	d74080e7          	jalr	-652(ra) # 80006160 <_Z8printIntiii>
    800053f4:	00005517          	auipc	a0,0x5
    800053f8:	ff450513          	addi	a0,a0,-12 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800053fc:	00001097          	auipc	ra,0x1
    80005400:	bb4080e7          	jalr	-1100(ra) # 80005fb0 <_Z11printStringPKc>
    80005404:	0400006f          	j	80005444 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005408:	00005517          	auipc	a0,0x5
    8000540c:	dc050513          	addi	a0,a0,-576 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80005410:	00001097          	auipc	ra,0x1
    80005414:	ba0080e7          	jalr	-1120(ra) # 80005fb0 <_Z11printStringPKc>
    80005418:	00000613          	li	a2,0
    8000541c:	00a00593          	li	a1,10
    80005420:	00048513          	mv	a0,s1
    80005424:	00001097          	auipc	ra,0x1
    80005428:	d3c080e7          	jalr	-708(ra) # 80006160 <_Z8printIntiii>
    8000542c:	00005517          	auipc	a0,0x5
    80005430:	fbc50513          	addi	a0,a0,-68 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80005434:	00001097          	auipc	ra,0x1
    80005438:	b7c080e7          	jalr	-1156(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000543c:	0014849b          	addiw	s1,s1,1
    80005440:	0ff4f493          	andi	s1,s1,255
    80005444:	00500793          	li	a5,5
    80005448:	fc97f0e3          	bgeu	a5,s1,80005408 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    8000544c:	00005517          	auipc	a0,0x5
    80005450:	d5450513          	addi	a0,a0,-684 # 8000a1a0 <CONSOLE_STATUS+0x190>
    80005454:	00001097          	auipc	ra,0x1
    80005458:	b5c080e7          	jalr	-1188(ra) # 80005fb0 <_Z11printStringPKc>
    finishedC = true;
    8000545c:	00100793          	li	a5,1
    80005460:	00008717          	auipc	a4,0x8
    80005464:	8ef708a3          	sb	a5,-1807(a4) # 8000cd51 <_ZL9finishedC>
    thread_dispatch();
    80005468:	ffffc097          	auipc	ra,0xffffc
    8000546c:	280080e7          	jalr	640(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80005470:	01813083          	ld	ra,24(sp)
    80005474:	01013403          	ld	s0,16(sp)
    80005478:	00813483          	ld	s1,8(sp)
    8000547c:	00013903          	ld	s2,0(sp)
    80005480:	02010113          	addi	sp,sp,32
    80005484:	00008067          	ret

0000000080005488 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005488:	fe010113          	addi	sp,sp,-32
    8000548c:	00113c23          	sd	ra,24(sp)
    80005490:	00813823          	sd	s0,16(sp)
    80005494:	00913423          	sd	s1,8(sp)
    80005498:	01213023          	sd	s2,0(sp)
    8000549c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800054a0:	00000913          	li	s2,0
    800054a4:	0380006f          	j	800054dc <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    800054a8:	ffffc097          	auipc	ra,0xffffc
    800054ac:	240080e7          	jalr	576(ra) # 800016e8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800054b0:	00148493          	addi	s1,s1,1
    800054b4:	000027b7          	lui	a5,0x2
    800054b8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800054bc:	0097ee63          	bltu	a5,s1,800054d8 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800054c0:	00000713          	li	a4,0
    800054c4:	000077b7          	lui	a5,0x7
    800054c8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800054cc:	fce7eee3          	bltu	a5,a4,800054a8 <_ZL11workerBodyBPv+0x20>
    800054d0:	00170713          	addi	a4,a4,1
    800054d4:	ff1ff06f          	j	800054c4 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800054d8:	00190913          	addi	s2,s2,1
    800054dc:	00f00793          	li	a5,15
    800054e0:	0527e063          	bltu	a5,s2,80005520 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800054e4:	00005517          	auipc	a0,0x5
    800054e8:	ccc50513          	addi	a0,a0,-820 # 8000a1b0 <CONSOLE_STATUS+0x1a0>
    800054ec:	00001097          	auipc	ra,0x1
    800054f0:	ac4080e7          	jalr	-1340(ra) # 80005fb0 <_Z11printStringPKc>
    800054f4:	00000613          	li	a2,0
    800054f8:	00a00593          	li	a1,10
    800054fc:	0009051b          	sext.w	a0,s2
    80005500:	00001097          	auipc	ra,0x1
    80005504:	c60080e7          	jalr	-928(ra) # 80006160 <_Z8printIntiii>
    80005508:	00005517          	auipc	a0,0x5
    8000550c:	ee050513          	addi	a0,a0,-288 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80005510:	00001097          	auipc	ra,0x1
    80005514:	aa0080e7          	jalr	-1376(ra) # 80005fb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005518:	00000493          	li	s1,0
    8000551c:	f99ff06f          	j	800054b4 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80005520:	00005517          	auipc	a0,0x5
    80005524:	c9850513          	addi	a0,a0,-872 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    80005528:	00001097          	auipc	ra,0x1
    8000552c:	a88080e7          	jalr	-1400(ra) # 80005fb0 <_Z11printStringPKc>
    finishedB = true;
    80005530:	00100793          	li	a5,1
    80005534:	00008717          	auipc	a4,0x8
    80005538:	80f70f23          	sb	a5,-2018(a4) # 8000cd52 <_ZL9finishedB>
    thread_dispatch();
    8000553c:	ffffc097          	auipc	ra,0xffffc
    80005540:	1ac080e7          	jalr	428(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80005544:	01813083          	ld	ra,24(sp)
    80005548:	01013403          	ld	s0,16(sp)
    8000554c:	00813483          	ld	s1,8(sp)
    80005550:	00013903          	ld	s2,0(sp)
    80005554:	02010113          	addi	sp,sp,32
    80005558:	00008067          	ret

000000008000555c <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    8000555c:	fe010113          	addi	sp,sp,-32
    80005560:	00113c23          	sd	ra,24(sp)
    80005564:	00813823          	sd	s0,16(sp)
    80005568:	00913423          	sd	s1,8(sp)
    8000556c:	01213023          	sd	s2,0(sp)
    80005570:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005574:	00000913          	li	s2,0
    80005578:	0380006f          	j	800055b0 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    8000557c:	ffffc097          	auipc	ra,0xffffc
    80005580:	16c080e7          	jalr	364(ra) # 800016e8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005584:	00148493          	addi	s1,s1,1
    80005588:	000027b7          	lui	a5,0x2
    8000558c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005590:	0097ee63          	bltu	a5,s1,800055ac <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005594:	00000713          	li	a4,0
    80005598:	000077b7          	lui	a5,0x7
    8000559c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800055a0:	fce7eee3          	bltu	a5,a4,8000557c <_ZL11workerBodyAPv+0x20>
    800055a4:	00170713          	addi	a4,a4,1
    800055a8:	ff1ff06f          	j	80005598 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800055ac:	00190913          	addi	s2,s2,1
    800055b0:	00900793          	li	a5,9
    800055b4:	0527e063          	bltu	a5,s2,800055f4 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800055b8:	00005517          	auipc	a0,0x5
    800055bc:	be050513          	addi	a0,a0,-1056 # 8000a198 <CONSOLE_STATUS+0x188>
    800055c0:	00001097          	auipc	ra,0x1
    800055c4:	9f0080e7          	jalr	-1552(ra) # 80005fb0 <_Z11printStringPKc>
    800055c8:	00000613          	li	a2,0
    800055cc:	00a00593          	li	a1,10
    800055d0:	0009051b          	sext.w	a0,s2
    800055d4:	00001097          	auipc	ra,0x1
    800055d8:	b8c080e7          	jalr	-1140(ra) # 80006160 <_Z8printIntiii>
    800055dc:	00005517          	auipc	a0,0x5
    800055e0:	e0c50513          	addi	a0,a0,-500 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800055e4:	00001097          	auipc	ra,0x1
    800055e8:	9cc080e7          	jalr	-1588(ra) # 80005fb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800055ec:	00000493          	li	s1,0
    800055f0:	f99ff06f          	j	80005588 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800055f4:	00005517          	auipc	a0,0x5
    800055f8:	bac50513          	addi	a0,a0,-1108 # 8000a1a0 <CONSOLE_STATUS+0x190>
    800055fc:	00001097          	auipc	ra,0x1
    80005600:	9b4080e7          	jalr	-1612(ra) # 80005fb0 <_Z11printStringPKc>
    finishedA = true;
    80005604:	00100793          	li	a5,1
    80005608:	00007717          	auipc	a4,0x7
    8000560c:	74f705a3          	sb	a5,1867(a4) # 8000cd53 <_ZL9finishedA>
}
    80005610:	01813083          	ld	ra,24(sp)
    80005614:	01013403          	ld	s0,16(sp)
    80005618:	00813483          	ld	s1,8(sp)
    8000561c:	00013903          	ld	s2,0(sp)
    80005620:	02010113          	addi	sp,sp,32
    80005624:	00008067          	ret

0000000080005628 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005628:	fd010113          	addi	sp,sp,-48
    8000562c:	02113423          	sd	ra,40(sp)
    80005630:	02813023          	sd	s0,32(sp)
    80005634:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005638:	00000613          	li	a2,0
    8000563c:	00000597          	auipc	a1,0x0
    80005640:	f2058593          	addi	a1,a1,-224 # 8000555c <_ZL11workerBodyAPv>
    80005644:	fd040513          	addi	a0,s0,-48
    80005648:	ffffc097          	auipc	ra,0xffffc
    8000564c:	f98080e7          	jalr	-104(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80005650:	00005517          	auipc	a0,0x5
    80005654:	be050513          	addi	a0,a0,-1056 # 8000a230 <CONSOLE_STATUS+0x220>
    80005658:	00001097          	auipc	ra,0x1
    8000565c:	958080e7          	jalr	-1704(ra) # 80005fb0 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005660:	00000613          	li	a2,0
    80005664:	00000597          	auipc	a1,0x0
    80005668:	e2458593          	addi	a1,a1,-476 # 80005488 <_ZL11workerBodyBPv>
    8000566c:	fd840513          	addi	a0,s0,-40
    80005670:	ffffc097          	auipc	ra,0xffffc
    80005674:	f70080e7          	jalr	-144(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80005678:	00005517          	auipc	a0,0x5
    8000567c:	bd050513          	addi	a0,a0,-1072 # 8000a248 <CONSOLE_STATUS+0x238>
    80005680:	00001097          	auipc	ra,0x1
    80005684:	930080e7          	jalr	-1744(ra) # 80005fb0 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005688:	00000613          	li	a2,0
    8000568c:	00000597          	auipc	a1,0x0
    80005690:	c7c58593          	addi	a1,a1,-900 # 80005308 <_ZL11workerBodyCPv>
    80005694:	fe040513          	addi	a0,s0,-32
    80005698:	ffffc097          	auipc	ra,0xffffc
    8000569c:	f48080e7          	jalr	-184(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    800056a0:	00005517          	auipc	a0,0x5
    800056a4:	bc050513          	addi	a0,a0,-1088 # 8000a260 <CONSOLE_STATUS+0x250>
    800056a8:	00001097          	auipc	ra,0x1
    800056ac:	908080e7          	jalr	-1784(ra) # 80005fb0 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800056b0:	00000613          	li	a2,0
    800056b4:	00000597          	auipc	a1,0x0
    800056b8:	b0c58593          	addi	a1,a1,-1268 # 800051c0 <_ZL11workerBodyDPv>
    800056bc:	fe840513          	addi	a0,s0,-24
    800056c0:	ffffc097          	auipc	ra,0xffffc
    800056c4:	f20080e7          	jalr	-224(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800056c8:	00005517          	auipc	a0,0x5
    800056cc:	bb050513          	addi	a0,a0,-1104 # 8000a278 <CONSOLE_STATUS+0x268>
    800056d0:	00001097          	auipc	ra,0x1
    800056d4:	8e0080e7          	jalr	-1824(ra) # 80005fb0 <_Z11printStringPKc>
    800056d8:	00c0006f          	j	800056e4 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800056dc:	ffffc097          	auipc	ra,0xffffc
    800056e0:	00c080e7          	jalr	12(ra) # 800016e8 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800056e4:	00007797          	auipc	a5,0x7
    800056e8:	66f7c783          	lbu	a5,1647(a5) # 8000cd53 <_ZL9finishedA>
    800056ec:	fe0788e3          	beqz	a5,800056dc <_Z18Threads_C_API_testv+0xb4>
    800056f0:	00007797          	auipc	a5,0x7
    800056f4:	6627c783          	lbu	a5,1634(a5) # 8000cd52 <_ZL9finishedB>
    800056f8:	fe0782e3          	beqz	a5,800056dc <_Z18Threads_C_API_testv+0xb4>
    800056fc:	00007797          	auipc	a5,0x7
    80005700:	6557c783          	lbu	a5,1621(a5) # 8000cd51 <_ZL9finishedC>
    80005704:	fc078ce3          	beqz	a5,800056dc <_Z18Threads_C_API_testv+0xb4>
    80005708:	00007797          	auipc	a5,0x7
    8000570c:	6487c783          	lbu	a5,1608(a5) # 8000cd50 <_ZL9finishedD>
    80005710:	fc0786e3          	beqz	a5,800056dc <_Z18Threads_C_API_testv+0xb4>
    }

}
    80005714:	02813083          	ld	ra,40(sp)
    80005718:	02013403          	ld	s0,32(sp)
    8000571c:	03010113          	addi	sp,sp,48
    80005720:	00008067          	ret

0000000080005724 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005724:	fd010113          	addi	sp,sp,-48
    80005728:	02113423          	sd	ra,40(sp)
    8000572c:	02813023          	sd	s0,32(sp)
    80005730:	00913c23          	sd	s1,24(sp)
    80005734:	01213823          	sd	s2,16(sp)
    80005738:	01313423          	sd	s3,8(sp)
    8000573c:	03010413          	addi	s0,sp,48
    80005740:	00050993          	mv	s3,a0
    80005744:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80005748:	00000913          	li	s2,0
    8000574c:	00c0006f          	j	80005758 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005750:	ffffd097          	auipc	ra,0xffffd
    80005754:	828080e7          	jalr	-2008(ra) # 80001f78 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80005758:	ffffc097          	auipc	ra,0xffffc
    8000575c:	108080e7          	jalr	264(ra) # 80001860 <_Z4getcv>
    80005760:	0005059b          	sext.w	a1,a0
    80005764:	01b00793          	li	a5,27
    80005768:	02f58a63          	beq	a1,a5,8000579c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    8000576c:	0084b503          	ld	a0,8(s1)
    80005770:	00001097          	auipc	ra,0x1
    80005774:	c64080e7          	jalr	-924(ra) # 800063d4 <_ZN9BufferCPP3putEi>
        i++;
    80005778:	0019071b          	addiw	a4,s2,1
    8000577c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005780:	0004a683          	lw	a3,0(s1)
    80005784:	0026979b          	slliw	a5,a3,0x2
    80005788:	00d787bb          	addw	a5,a5,a3
    8000578c:	0017979b          	slliw	a5,a5,0x1
    80005790:	02f767bb          	remw	a5,a4,a5
    80005794:	fc0792e3          	bnez	a5,80005758 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80005798:	fb9ff06f          	j	80005750 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    8000579c:	00100793          	li	a5,1
    800057a0:	00007717          	auipc	a4,0x7
    800057a4:	5af72c23          	sw	a5,1464(a4) # 8000cd58 <_ZL9threadEnd>
    td->buffer->put('!');
    800057a8:	0209b783          	ld	a5,32(s3)
    800057ac:	02100593          	li	a1,33
    800057b0:	0087b503          	ld	a0,8(a5)
    800057b4:	00001097          	auipc	ra,0x1
    800057b8:	c20080e7          	jalr	-992(ra) # 800063d4 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800057bc:	0104b503          	ld	a0,16(s1)
    800057c0:	ffffd097          	auipc	ra,0xffffd
    800057c4:	8bc080e7          	jalr	-1860(ra) # 8000207c <_ZN9Semaphore6signalEv>
}
    800057c8:	02813083          	ld	ra,40(sp)
    800057cc:	02013403          	ld	s0,32(sp)
    800057d0:	01813483          	ld	s1,24(sp)
    800057d4:	01013903          	ld	s2,16(sp)
    800057d8:	00813983          	ld	s3,8(sp)
    800057dc:	03010113          	addi	sp,sp,48
    800057e0:	00008067          	ret

00000000800057e4 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800057e4:	fe010113          	addi	sp,sp,-32
    800057e8:	00113c23          	sd	ra,24(sp)
    800057ec:	00813823          	sd	s0,16(sp)
    800057f0:	00913423          	sd	s1,8(sp)
    800057f4:	01213023          	sd	s2,0(sp)
    800057f8:	02010413          	addi	s0,sp,32
    800057fc:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005800:	00000913          	li	s2,0
    80005804:	00c0006f          	j	80005810 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005808:	ffffc097          	auipc	ra,0xffffc
    8000580c:	770080e7          	jalr	1904(ra) # 80001f78 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80005810:	00007797          	auipc	a5,0x7
    80005814:	5487a783          	lw	a5,1352(a5) # 8000cd58 <_ZL9threadEnd>
    80005818:	02079e63          	bnez	a5,80005854 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000581c:	0004a583          	lw	a1,0(s1)
    80005820:	0305859b          	addiw	a1,a1,48
    80005824:	0084b503          	ld	a0,8(s1)
    80005828:	00001097          	auipc	ra,0x1
    8000582c:	bac080e7          	jalr	-1108(ra) # 800063d4 <_ZN9BufferCPP3putEi>
        i++;
    80005830:	0019071b          	addiw	a4,s2,1
    80005834:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005838:	0004a683          	lw	a3,0(s1)
    8000583c:	0026979b          	slliw	a5,a3,0x2
    80005840:	00d787bb          	addw	a5,a5,a3
    80005844:	0017979b          	slliw	a5,a5,0x1
    80005848:	02f767bb          	remw	a5,a4,a5
    8000584c:	fc0792e3          	bnez	a5,80005810 <_ZN12ProducerSync8producerEPv+0x2c>
    80005850:	fb9ff06f          	j	80005808 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005854:	0104b503          	ld	a0,16(s1)
    80005858:	ffffd097          	auipc	ra,0xffffd
    8000585c:	824080e7          	jalr	-2012(ra) # 8000207c <_ZN9Semaphore6signalEv>
}
    80005860:	01813083          	ld	ra,24(sp)
    80005864:	01013403          	ld	s0,16(sp)
    80005868:	00813483          	ld	s1,8(sp)
    8000586c:	00013903          	ld	s2,0(sp)
    80005870:	02010113          	addi	sp,sp,32
    80005874:	00008067          	ret

0000000080005878 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80005878:	fd010113          	addi	sp,sp,-48
    8000587c:	02113423          	sd	ra,40(sp)
    80005880:	02813023          	sd	s0,32(sp)
    80005884:	00913c23          	sd	s1,24(sp)
    80005888:	01213823          	sd	s2,16(sp)
    8000588c:	01313423          	sd	s3,8(sp)
    80005890:	01413023          	sd	s4,0(sp)
    80005894:	03010413          	addi	s0,sp,48
    80005898:	00050993          	mv	s3,a0
    8000589c:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800058a0:	00000a13          	li	s4,0
    800058a4:	01c0006f          	j	800058c0 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    800058a8:	ffffc097          	auipc	ra,0xffffc
    800058ac:	6d0080e7          	jalr	1744(ra) # 80001f78 <_ZN6Thread8dispatchEv>
    800058b0:	0500006f          	j	80005900 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800058b4:	00a00513          	li	a0,10
    800058b8:	ffffc097          	auipc	ra,0xffffc
    800058bc:	fdc080e7          	jalr	-36(ra) # 80001894 <_Z4putcc>
    while (!threadEnd) {
    800058c0:	00007797          	auipc	a5,0x7
    800058c4:	4987a783          	lw	a5,1176(a5) # 8000cd58 <_ZL9threadEnd>
    800058c8:	06079263          	bnez	a5,8000592c <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800058cc:	00893503          	ld	a0,8(s2)
    800058d0:	00001097          	auipc	ra,0x1
    800058d4:	b94080e7          	jalr	-1132(ra) # 80006464 <_ZN9BufferCPP3getEv>
        i++;
    800058d8:	001a049b          	addiw	s1,s4,1
    800058dc:	00048a1b          	sext.w	s4,s1
        putc(key);
    800058e0:	0ff57513          	andi	a0,a0,255
    800058e4:	ffffc097          	auipc	ra,0xffffc
    800058e8:	fb0080e7          	jalr	-80(ra) # 80001894 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800058ec:	00092703          	lw	a4,0(s2)
    800058f0:	0027179b          	slliw	a5,a4,0x2
    800058f4:	00e787bb          	addw	a5,a5,a4
    800058f8:	02f4e7bb          	remw	a5,s1,a5
    800058fc:	fa0786e3          	beqz	a5,800058a8 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80005900:	05000793          	li	a5,80
    80005904:	02f4e4bb          	remw	s1,s1,a5
    80005908:	fa049ce3          	bnez	s1,800058c0 <_ZN12ConsumerSync8consumerEPv+0x48>
    8000590c:	fa9ff06f          	j	800058b4 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80005910:	0209b783          	ld	a5,32(s3)
    80005914:	0087b503          	ld	a0,8(a5)
    80005918:	00001097          	auipc	ra,0x1
    8000591c:	b4c080e7          	jalr	-1204(ra) # 80006464 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80005920:	0ff57513          	andi	a0,a0,255
    80005924:	ffffc097          	auipc	ra,0xffffc
    80005928:	704080e7          	jalr	1796(ra) # 80002028 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    8000592c:	0209b783          	ld	a5,32(s3)
    80005930:	0087b503          	ld	a0,8(a5)
    80005934:	00001097          	auipc	ra,0x1
    80005938:	bbc080e7          	jalr	-1092(ra) # 800064f0 <_ZN9BufferCPP6getCntEv>
    8000593c:	fca04ae3          	bgtz	a0,80005910 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80005940:	01093503          	ld	a0,16(s2)
    80005944:	ffffc097          	auipc	ra,0xffffc
    80005948:	738080e7          	jalr	1848(ra) # 8000207c <_ZN9Semaphore6signalEv>
}
    8000594c:	02813083          	ld	ra,40(sp)
    80005950:	02013403          	ld	s0,32(sp)
    80005954:	01813483          	ld	s1,24(sp)
    80005958:	01013903          	ld	s2,16(sp)
    8000595c:	00813983          	ld	s3,8(sp)
    80005960:	00013a03          	ld	s4,0(sp)
    80005964:	03010113          	addi	sp,sp,48
    80005968:	00008067          	ret

000000008000596c <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    8000596c:	f8010113          	addi	sp,sp,-128
    80005970:	06113c23          	sd	ra,120(sp)
    80005974:	06813823          	sd	s0,112(sp)
    80005978:	06913423          	sd	s1,104(sp)
    8000597c:	07213023          	sd	s2,96(sp)
    80005980:	05313c23          	sd	s3,88(sp)
    80005984:	05413823          	sd	s4,80(sp)
    80005988:	05513423          	sd	s5,72(sp)
    8000598c:	05613023          	sd	s6,64(sp)
    80005990:	03713c23          	sd	s7,56(sp)
    80005994:	03813823          	sd	s8,48(sp)
    80005998:	03913423          	sd	s9,40(sp)
    8000599c:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800059a0:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800059a4:	00004517          	auipc	a0,0x4
    800059a8:	70c50513          	addi	a0,a0,1804 # 8000a0b0 <CONSOLE_STATUS+0xa0>
    800059ac:	00000097          	auipc	ra,0x0
    800059b0:	604080e7          	jalr	1540(ra) # 80005fb0 <_Z11printStringPKc>
    getString(input, 30);
    800059b4:	01e00593          	li	a1,30
    800059b8:	f8040493          	addi	s1,s0,-128
    800059bc:	00048513          	mv	a0,s1
    800059c0:	00000097          	auipc	ra,0x0
    800059c4:	678080e7          	jalr	1656(ra) # 80006038 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800059c8:	00048513          	mv	a0,s1
    800059cc:	00000097          	auipc	ra,0x0
    800059d0:	744080e7          	jalr	1860(ra) # 80006110 <_Z11stringToIntPKc>
    800059d4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800059d8:	00004517          	auipc	a0,0x4
    800059dc:	6f850513          	addi	a0,a0,1784 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    800059e0:	00000097          	auipc	ra,0x0
    800059e4:	5d0080e7          	jalr	1488(ra) # 80005fb0 <_Z11printStringPKc>
    getString(input, 30);
    800059e8:	01e00593          	li	a1,30
    800059ec:	00048513          	mv	a0,s1
    800059f0:	00000097          	auipc	ra,0x0
    800059f4:	648080e7          	jalr	1608(ra) # 80006038 <_Z9getStringPci>
    n = stringToInt(input);
    800059f8:	00048513          	mv	a0,s1
    800059fc:	00000097          	auipc	ra,0x0
    80005a00:	714080e7          	jalr	1812(ra) # 80006110 <_Z11stringToIntPKc>
    80005a04:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005a08:	00004517          	auipc	a0,0x4
    80005a0c:	6e850513          	addi	a0,a0,1768 # 8000a0f0 <CONSOLE_STATUS+0xe0>
    80005a10:	00000097          	auipc	ra,0x0
    80005a14:	5a0080e7          	jalr	1440(ra) # 80005fb0 <_Z11printStringPKc>
    80005a18:	00000613          	li	a2,0
    80005a1c:	00a00593          	li	a1,10
    80005a20:	00090513          	mv	a0,s2
    80005a24:	00000097          	auipc	ra,0x0
    80005a28:	73c080e7          	jalr	1852(ra) # 80006160 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005a2c:	00004517          	auipc	a0,0x4
    80005a30:	6dc50513          	addi	a0,a0,1756 # 8000a108 <CONSOLE_STATUS+0xf8>
    80005a34:	00000097          	auipc	ra,0x0
    80005a38:	57c080e7          	jalr	1404(ra) # 80005fb0 <_Z11printStringPKc>
    80005a3c:	00000613          	li	a2,0
    80005a40:	00a00593          	li	a1,10
    80005a44:	00048513          	mv	a0,s1
    80005a48:	00000097          	auipc	ra,0x0
    80005a4c:	718080e7          	jalr	1816(ra) # 80006160 <_Z8printIntiii>
    printString(".\n");
    80005a50:	00004517          	auipc	a0,0x4
    80005a54:	6d050513          	addi	a0,a0,1744 # 8000a120 <CONSOLE_STATUS+0x110>
    80005a58:	00000097          	auipc	ra,0x0
    80005a5c:	558080e7          	jalr	1368(ra) # 80005fb0 <_Z11printStringPKc>
    if(threadNum > n) {
    80005a60:	0324c463          	blt	s1,s2,80005a88 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005a64:	03205c63          	blez	s2,80005a9c <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80005a68:	03800513          	li	a0,56
    80005a6c:	ffffc097          	auipc	ra,0xffffc
    80005a70:	35c080e7          	jalr	860(ra) # 80001dc8 <_Znwm>
    80005a74:	00050a93          	mv	s5,a0
    80005a78:	00048593          	mv	a1,s1
    80005a7c:	00001097          	auipc	ra,0x1
    80005a80:	804080e7          	jalr	-2044(ra) # 80006280 <_ZN9BufferCPPC1Ei>
    80005a84:	0300006f          	j	80005ab4 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005a88:	00004517          	auipc	a0,0x4
    80005a8c:	6a050513          	addi	a0,a0,1696 # 8000a128 <CONSOLE_STATUS+0x118>
    80005a90:	00000097          	auipc	ra,0x0
    80005a94:	520080e7          	jalr	1312(ra) # 80005fb0 <_Z11printStringPKc>
        return;
    80005a98:	0140006f          	j	80005aac <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005a9c:	00004517          	auipc	a0,0x4
    80005aa0:	6cc50513          	addi	a0,a0,1740 # 8000a168 <CONSOLE_STATUS+0x158>
    80005aa4:	00000097          	auipc	ra,0x0
    80005aa8:	50c080e7          	jalr	1292(ra) # 80005fb0 <_Z11printStringPKc>
        return;
    80005aac:	000b8113          	mv	sp,s7
    80005ab0:	2380006f          	j	80005ce8 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80005ab4:	01000513          	li	a0,16
    80005ab8:	ffffc097          	auipc	ra,0xffffc
    80005abc:	310080e7          	jalr	784(ra) # 80001dc8 <_Znwm>
    80005ac0:	00050493          	mv	s1,a0
    80005ac4:	00000593          	li	a1,0
    80005ac8:	ffffc097          	auipc	ra,0xffffc
    80005acc:	5e0080e7          	jalr	1504(ra) # 800020a8 <_ZN9SemaphoreC1Ej>
    80005ad0:	00007797          	auipc	a5,0x7
    80005ad4:	2897b823          	sd	s1,656(a5) # 8000cd60 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80005ad8:	00391793          	slli	a5,s2,0x3
    80005adc:	00f78793          	addi	a5,a5,15
    80005ae0:	ff07f793          	andi	a5,a5,-16
    80005ae4:	40f10133          	sub	sp,sp,a5
    80005ae8:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80005aec:	0019071b          	addiw	a4,s2,1
    80005af0:	00171793          	slli	a5,a4,0x1
    80005af4:	00e787b3          	add	a5,a5,a4
    80005af8:	00379793          	slli	a5,a5,0x3
    80005afc:	00f78793          	addi	a5,a5,15
    80005b00:	ff07f793          	andi	a5,a5,-16
    80005b04:	40f10133          	sub	sp,sp,a5
    80005b08:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80005b0c:	00191c13          	slli	s8,s2,0x1
    80005b10:	012c07b3          	add	a5,s8,s2
    80005b14:	00379793          	slli	a5,a5,0x3
    80005b18:	00fa07b3          	add	a5,s4,a5
    80005b1c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005b20:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005b24:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80005b28:	02800513          	li	a0,40
    80005b2c:	ffffc097          	auipc	ra,0xffffc
    80005b30:	29c080e7          	jalr	668(ra) # 80001dc8 <_Znwm>
    80005b34:	00050b13          	mv	s6,a0
    80005b38:	012c0c33          	add	s8,s8,s2
    80005b3c:	003c1c13          	slli	s8,s8,0x3
    80005b40:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80005b44:	ffffc097          	auipc	ra,0xffffc
    80005b48:	484080e7          	jalr	1156(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80005b4c:	00007797          	auipc	a5,0x7
    80005b50:	07478793          	addi	a5,a5,116 # 8000cbc0 <_ZTV12ConsumerSync+0x10>
    80005b54:	00fb3023          	sd	a5,0(s6)
    80005b58:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80005b5c:	000b0513          	mv	a0,s6
    80005b60:	ffffc097          	auipc	ra,0xffffc
    80005b64:	3b8080e7          	jalr	952(ra) # 80001f18 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005b68:	00000493          	li	s1,0
    80005b6c:	0380006f          	j	80005ba4 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80005b70:	00007797          	auipc	a5,0x7
    80005b74:	02878793          	addi	a5,a5,40 # 8000cb98 <_ZTV12ProducerSync+0x10>
    80005b78:	00fcb023          	sd	a5,0(s9)
    80005b7c:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80005b80:	00349793          	slli	a5,s1,0x3
    80005b84:	00f987b3          	add	a5,s3,a5
    80005b88:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80005b8c:	00349793          	slli	a5,s1,0x3
    80005b90:	00f987b3          	add	a5,s3,a5
    80005b94:	0007b503          	ld	a0,0(a5)
    80005b98:	ffffc097          	auipc	ra,0xffffc
    80005b9c:	380080e7          	jalr	896(ra) # 80001f18 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005ba0:	0014849b          	addiw	s1,s1,1
    80005ba4:	0b24d063          	bge	s1,s2,80005c44 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80005ba8:	00149793          	slli	a5,s1,0x1
    80005bac:	009787b3          	add	a5,a5,s1
    80005bb0:	00379793          	slli	a5,a5,0x3
    80005bb4:	00fa07b3          	add	a5,s4,a5
    80005bb8:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80005bbc:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80005bc0:	00007717          	auipc	a4,0x7
    80005bc4:	1a073703          	ld	a4,416(a4) # 8000cd60 <_ZL10waitForAll>
    80005bc8:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80005bcc:	02905863          	blez	s1,80005bfc <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80005bd0:	02800513          	li	a0,40
    80005bd4:	ffffc097          	auipc	ra,0xffffc
    80005bd8:	1f4080e7          	jalr	500(ra) # 80001dc8 <_Znwm>
    80005bdc:	00050c93          	mv	s9,a0
    80005be0:	00149c13          	slli	s8,s1,0x1
    80005be4:	009c0c33          	add	s8,s8,s1
    80005be8:	003c1c13          	slli	s8,s8,0x3
    80005bec:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80005bf0:	ffffc097          	auipc	ra,0xffffc
    80005bf4:	3d8080e7          	jalr	984(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80005bf8:	f79ff06f          	j	80005b70 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80005bfc:	02800513          	li	a0,40
    80005c00:	ffffc097          	auipc	ra,0xffffc
    80005c04:	1c8080e7          	jalr	456(ra) # 80001dc8 <_Znwm>
    80005c08:	00050c93          	mv	s9,a0
    80005c0c:	00149c13          	slli	s8,s1,0x1
    80005c10:	009c0c33          	add	s8,s8,s1
    80005c14:	003c1c13          	slli	s8,s8,0x3
    80005c18:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005c1c:	ffffc097          	auipc	ra,0xffffc
    80005c20:	3ac080e7          	jalr	940(ra) # 80001fc8 <_ZN6ThreadC1Ev>
    80005c24:	00007797          	auipc	a5,0x7
    80005c28:	f4c78793          	addi	a5,a5,-180 # 8000cb70 <_ZTV16ProducerKeyboard+0x10>
    80005c2c:	00fcb023          	sd	a5,0(s9)
    80005c30:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005c34:	00349793          	slli	a5,s1,0x3
    80005c38:	00f987b3          	add	a5,s3,a5
    80005c3c:	0197b023          	sd	s9,0(a5)
    80005c40:	f4dff06f          	j	80005b8c <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80005c44:	ffffc097          	auipc	ra,0xffffc
    80005c48:	334080e7          	jalr	820(ra) # 80001f78 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005c4c:	00000493          	li	s1,0
    80005c50:	00994e63          	blt	s2,s1,80005c6c <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80005c54:	00007517          	auipc	a0,0x7
    80005c58:	10c53503          	ld	a0,268(a0) # 8000cd60 <_ZL10waitForAll>
    80005c5c:	ffffc097          	auipc	ra,0xffffc
    80005c60:	3f4080e7          	jalr	1012(ra) # 80002050 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80005c64:	0014849b          	addiw	s1,s1,1
    80005c68:	fe9ff06f          	j	80005c50 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80005c6c:	00000493          	li	s1,0
    80005c70:	0080006f          	j	80005c78 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80005c74:	0014849b          	addiw	s1,s1,1
    80005c78:	0324d263          	bge	s1,s2,80005c9c <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80005c7c:	00349793          	slli	a5,s1,0x3
    80005c80:	00f987b3          	add	a5,s3,a5
    80005c84:	0007b503          	ld	a0,0(a5)
    80005c88:	fe0506e3          	beqz	a0,80005c74 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80005c8c:	00053783          	ld	a5,0(a0)
    80005c90:	0087b783          	ld	a5,8(a5)
    80005c94:	000780e7          	jalr	a5
    80005c98:	fddff06f          	j	80005c74 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80005c9c:	000b0a63          	beqz	s6,80005cb0 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80005ca0:	000b3783          	ld	a5,0(s6)
    80005ca4:	0087b783          	ld	a5,8(a5)
    80005ca8:	000b0513          	mv	a0,s6
    80005cac:	000780e7          	jalr	a5
    delete waitForAll;
    80005cb0:	00007517          	auipc	a0,0x7
    80005cb4:	0b053503          	ld	a0,176(a0) # 8000cd60 <_ZL10waitForAll>
    80005cb8:	00050863          	beqz	a0,80005cc8 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80005cbc:	00053783          	ld	a5,0(a0)
    80005cc0:	0087b783          	ld	a5,8(a5)
    80005cc4:	000780e7          	jalr	a5
    delete buffer;
    80005cc8:	000a8e63          	beqz	s5,80005ce4 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80005ccc:	000a8513          	mv	a0,s5
    80005cd0:	00001097          	auipc	ra,0x1
    80005cd4:	8a8080e7          	jalr	-1880(ra) # 80006578 <_ZN9BufferCPPD1Ev>
    80005cd8:	000a8513          	mv	a0,s5
    80005cdc:	ffffc097          	auipc	ra,0xffffc
    80005ce0:	13c080e7          	jalr	316(ra) # 80001e18 <_ZdlPv>
    80005ce4:	000b8113          	mv	sp,s7

}
    80005ce8:	f8040113          	addi	sp,s0,-128
    80005cec:	07813083          	ld	ra,120(sp)
    80005cf0:	07013403          	ld	s0,112(sp)
    80005cf4:	06813483          	ld	s1,104(sp)
    80005cf8:	06013903          	ld	s2,96(sp)
    80005cfc:	05813983          	ld	s3,88(sp)
    80005d00:	05013a03          	ld	s4,80(sp)
    80005d04:	04813a83          	ld	s5,72(sp)
    80005d08:	04013b03          	ld	s6,64(sp)
    80005d0c:	03813b83          	ld	s7,56(sp)
    80005d10:	03013c03          	ld	s8,48(sp)
    80005d14:	02813c83          	ld	s9,40(sp)
    80005d18:	08010113          	addi	sp,sp,128
    80005d1c:	00008067          	ret
    80005d20:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005d24:	000a8513          	mv	a0,s5
    80005d28:	ffffc097          	auipc	ra,0xffffc
    80005d2c:	0f0080e7          	jalr	240(ra) # 80001e18 <_ZdlPv>
    80005d30:	00048513          	mv	a0,s1
    80005d34:	00008097          	auipc	ra,0x8
    80005d38:	114080e7          	jalr	276(ra) # 8000de48 <_Unwind_Resume>
    80005d3c:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80005d40:	00048513          	mv	a0,s1
    80005d44:	ffffc097          	auipc	ra,0xffffc
    80005d48:	0d4080e7          	jalr	212(ra) # 80001e18 <_ZdlPv>
    80005d4c:	00090513          	mv	a0,s2
    80005d50:	00008097          	auipc	ra,0x8
    80005d54:	0f8080e7          	jalr	248(ra) # 8000de48 <_Unwind_Resume>
    80005d58:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80005d5c:	000b0513          	mv	a0,s6
    80005d60:	ffffc097          	auipc	ra,0xffffc
    80005d64:	0b8080e7          	jalr	184(ra) # 80001e18 <_ZdlPv>
    80005d68:	00048513          	mv	a0,s1
    80005d6c:	00008097          	auipc	ra,0x8
    80005d70:	0dc080e7          	jalr	220(ra) # 8000de48 <_Unwind_Resume>
    80005d74:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80005d78:	000c8513          	mv	a0,s9
    80005d7c:	ffffc097          	auipc	ra,0xffffc
    80005d80:	09c080e7          	jalr	156(ra) # 80001e18 <_ZdlPv>
    80005d84:	00048513          	mv	a0,s1
    80005d88:	00008097          	auipc	ra,0x8
    80005d8c:	0c0080e7          	jalr	192(ra) # 8000de48 <_Unwind_Resume>
    80005d90:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80005d94:	000c8513          	mv	a0,s9
    80005d98:	ffffc097          	auipc	ra,0xffffc
    80005d9c:	080080e7          	jalr	128(ra) # 80001e18 <_ZdlPv>
    80005da0:	00048513          	mv	a0,s1
    80005da4:	00008097          	auipc	ra,0x8
    80005da8:	0a4080e7          	jalr	164(ra) # 8000de48 <_Unwind_Resume>

0000000080005dac <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80005dac:	ff010113          	addi	sp,sp,-16
    80005db0:	00113423          	sd	ra,8(sp)
    80005db4:	00813023          	sd	s0,0(sp)
    80005db8:	01010413          	addi	s0,sp,16
    80005dbc:	00007797          	auipc	a5,0x7
    80005dc0:	e0478793          	addi	a5,a5,-508 # 8000cbc0 <_ZTV12ConsumerSync+0x10>
    80005dc4:	00f53023          	sd	a5,0(a0)
    80005dc8:	ffffc097          	auipc	ra,0xffffc
    80005dcc:	f58080e7          	jalr	-168(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005dd0:	00813083          	ld	ra,8(sp)
    80005dd4:	00013403          	ld	s0,0(sp)
    80005dd8:	01010113          	addi	sp,sp,16
    80005ddc:	00008067          	ret

0000000080005de0 <_ZN12ConsumerSyncD0Ev>:
    80005de0:	fe010113          	addi	sp,sp,-32
    80005de4:	00113c23          	sd	ra,24(sp)
    80005de8:	00813823          	sd	s0,16(sp)
    80005dec:	00913423          	sd	s1,8(sp)
    80005df0:	02010413          	addi	s0,sp,32
    80005df4:	00050493          	mv	s1,a0
    80005df8:	00007797          	auipc	a5,0x7
    80005dfc:	dc878793          	addi	a5,a5,-568 # 8000cbc0 <_ZTV12ConsumerSync+0x10>
    80005e00:	00f53023          	sd	a5,0(a0)
    80005e04:	ffffc097          	auipc	ra,0xffffc
    80005e08:	f1c080e7          	jalr	-228(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005e0c:	00048513          	mv	a0,s1
    80005e10:	ffffc097          	auipc	ra,0xffffc
    80005e14:	008080e7          	jalr	8(ra) # 80001e18 <_ZdlPv>
    80005e18:	01813083          	ld	ra,24(sp)
    80005e1c:	01013403          	ld	s0,16(sp)
    80005e20:	00813483          	ld	s1,8(sp)
    80005e24:	02010113          	addi	sp,sp,32
    80005e28:	00008067          	ret

0000000080005e2c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80005e2c:	ff010113          	addi	sp,sp,-16
    80005e30:	00113423          	sd	ra,8(sp)
    80005e34:	00813023          	sd	s0,0(sp)
    80005e38:	01010413          	addi	s0,sp,16
    80005e3c:	00007797          	auipc	a5,0x7
    80005e40:	d5c78793          	addi	a5,a5,-676 # 8000cb98 <_ZTV12ProducerSync+0x10>
    80005e44:	00f53023          	sd	a5,0(a0)
    80005e48:	ffffc097          	auipc	ra,0xffffc
    80005e4c:	ed8080e7          	jalr	-296(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005e50:	00813083          	ld	ra,8(sp)
    80005e54:	00013403          	ld	s0,0(sp)
    80005e58:	01010113          	addi	sp,sp,16
    80005e5c:	00008067          	ret

0000000080005e60 <_ZN12ProducerSyncD0Ev>:
    80005e60:	fe010113          	addi	sp,sp,-32
    80005e64:	00113c23          	sd	ra,24(sp)
    80005e68:	00813823          	sd	s0,16(sp)
    80005e6c:	00913423          	sd	s1,8(sp)
    80005e70:	02010413          	addi	s0,sp,32
    80005e74:	00050493          	mv	s1,a0
    80005e78:	00007797          	auipc	a5,0x7
    80005e7c:	d2078793          	addi	a5,a5,-736 # 8000cb98 <_ZTV12ProducerSync+0x10>
    80005e80:	00f53023          	sd	a5,0(a0)
    80005e84:	ffffc097          	auipc	ra,0xffffc
    80005e88:	e9c080e7          	jalr	-356(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005e8c:	00048513          	mv	a0,s1
    80005e90:	ffffc097          	auipc	ra,0xffffc
    80005e94:	f88080e7          	jalr	-120(ra) # 80001e18 <_ZdlPv>
    80005e98:	01813083          	ld	ra,24(sp)
    80005e9c:	01013403          	ld	s0,16(sp)
    80005ea0:	00813483          	ld	s1,8(sp)
    80005ea4:	02010113          	addi	sp,sp,32
    80005ea8:	00008067          	ret

0000000080005eac <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80005eac:	ff010113          	addi	sp,sp,-16
    80005eb0:	00113423          	sd	ra,8(sp)
    80005eb4:	00813023          	sd	s0,0(sp)
    80005eb8:	01010413          	addi	s0,sp,16
    80005ebc:	00007797          	auipc	a5,0x7
    80005ec0:	cb478793          	addi	a5,a5,-844 # 8000cb70 <_ZTV16ProducerKeyboard+0x10>
    80005ec4:	00f53023          	sd	a5,0(a0)
    80005ec8:	ffffc097          	auipc	ra,0xffffc
    80005ecc:	e58080e7          	jalr	-424(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005ed0:	00813083          	ld	ra,8(sp)
    80005ed4:	00013403          	ld	s0,0(sp)
    80005ed8:	01010113          	addi	sp,sp,16
    80005edc:	00008067          	ret

0000000080005ee0 <_ZN16ProducerKeyboardD0Ev>:
    80005ee0:	fe010113          	addi	sp,sp,-32
    80005ee4:	00113c23          	sd	ra,24(sp)
    80005ee8:	00813823          	sd	s0,16(sp)
    80005eec:	00913423          	sd	s1,8(sp)
    80005ef0:	02010413          	addi	s0,sp,32
    80005ef4:	00050493          	mv	s1,a0
    80005ef8:	00007797          	auipc	a5,0x7
    80005efc:	c7878793          	addi	a5,a5,-904 # 8000cb70 <_ZTV16ProducerKeyboard+0x10>
    80005f00:	00f53023          	sd	a5,0(a0)
    80005f04:	ffffc097          	auipc	ra,0xffffc
    80005f08:	e1c080e7          	jalr	-484(ra) # 80001d20 <_ZN6ThreadD1Ev>
    80005f0c:	00048513          	mv	a0,s1
    80005f10:	ffffc097          	auipc	ra,0xffffc
    80005f14:	f08080e7          	jalr	-248(ra) # 80001e18 <_ZdlPv>
    80005f18:	01813083          	ld	ra,24(sp)
    80005f1c:	01013403          	ld	s0,16(sp)
    80005f20:	00813483          	ld	s1,8(sp)
    80005f24:	02010113          	addi	sp,sp,32
    80005f28:	00008067          	ret

0000000080005f2c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80005f2c:	ff010113          	addi	sp,sp,-16
    80005f30:	00113423          	sd	ra,8(sp)
    80005f34:	00813023          	sd	s0,0(sp)
    80005f38:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80005f3c:	02053583          	ld	a1,32(a0)
    80005f40:	fffff097          	auipc	ra,0xfffff
    80005f44:	7e4080e7          	jalr	2020(ra) # 80005724 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80005f48:	00813083          	ld	ra,8(sp)
    80005f4c:	00013403          	ld	s0,0(sp)
    80005f50:	01010113          	addi	sp,sp,16
    80005f54:	00008067          	ret

0000000080005f58 <_ZN12ProducerSync3runEv>:
    void run() override {
    80005f58:	ff010113          	addi	sp,sp,-16
    80005f5c:	00113423          	sd	ra,8(sp)
    80005f60:	00813023          	sd	s0,0(sp)
    80005f64:	01010413          	addi	s0,sp,16
        producer(td);
    80005f68:	02053583          	ld	a1,32(a0)
    80005f6c:	00000097          	auipc	ra,0x0
    80005f70:	878080e7          	jalr	-1928(ra) # 800057e4 <_ZN12ProducerSync8producerEPv>
    }
    80005f74:	00813083          	ld	ra,8(sp)
    80005f78:	00013403          	ld	s0,0(sp)
    80005f7c:	01010113          	addi	sp,sp,16
    80005f80:	00008067          	ret

0000000080005f84 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80005f84:	ff010113          	addi	sp,sp,-16
    80005f88:	00113423          	sd	ra,8(sp)
    80005f8c:	00813023          	sd	s0,0(sp)
    80005f90:	01010413          	addi	s0,sp,16
        consumer(td);
    80005f94:	02053583          	ld	a1,32(a0)
    80005f98:	00000097          	auipc	ra,0x0
    80005f9c:	8e0080e7          	jalr	-1824(ra) # 80005878 <_ZN12ConsumerSync8consumerEPv>
    }
    80005fa0:	00813083          	ld	ra,8(sp)
    80005fa4:	00013403          	ld	s0,0(sp)
    80005fa8:	01010113          	addi	sp,sp,16
    80005fac:	00008067          	ret

0000000080005fb0 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80005fb0:	fe010113          	addi	sp,sp,-32
    80005fb4:	00113c23          	sd	ra,24(sp)
    80005fb8:	00813823          	sd	s0,16(sp)
    80005fbc:	00913423          	sd	s1,8(sp)
    80005fc0:	02010413          	addi	s0,sp,32
    80005fc4:	00050493          	mv	s1,a0
    LOCK();
    80005fc8:	00100613          	li	a2,1
    80005fcc:	00000593          	li	a1,0
    80005fd0:	00007517          	auipc	a0,0x7
    80005fd4:	d9850513          	addi	a0,a0,-616 # 8000cd68 <lockPrint>
    80005fd8:	ffffb097          	auipc	ra,0xffffb
    80005fdc:	564080e7          	jalr	1380(ra) # 8000153c <copy_and_swap>
    80005fe0:	00050863          	beqz	a0,80005ff0 <_Z11printStringPKc+0x40>
    80005fe4:	ffffb097          	auipc	ra,0xffffb
    80005fe8:	704080e7          	jalr	1796(ra) # 800016e8 <_Z15thread_dispatchv>
    80005fec:	fddff06f          	j	80005fc8 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80005ff0:	0004c503          	lbu	a0,0(s1)
    80005ff4:	00050a63          	beqz	a0,80006008 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80005ff8:	ffffc097          	auipc	ra,0xffffc
    80005ffc:	89c080e7          	jalr	-1892(ra) # 80001894 <_Z4putcc>
        string++;
    80006000:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80006004:	fedff06f          	j	80005ff0 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80006008:	00000613          	li	a2,0
    8000600c:	00100593          	li	a1,1
    80006010:	00007517          	auipc	a0,0x7
    80006014:	d5850513          	addi	a0,a0,-680 # 8000cd68 <lockPrint>
    80006018:	ffffb097          	auipc	ra,0xffffb
    8000601c:	524080e7          	jalr	1316(ra) # 8000153c <copy_and_swap>
    80006020:	fe0514e3          	bnez	a0,80006008 <_Z11printStringPKc+0x58>
}
    80006024:	01813083          	ld	ra,24(sp)
    80006028:	01013403          	ld	s0,16(sp)
    8000602c:	00813483          	ld	s1,8(sp)
    80006030:	02010113          	addi	sp,sp,32
    80006034:	00008067          	ret

0000000080006038 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80006038:	fd010113          	addi	sp,sp,-48
    8000603c:	02113423          	sd	ra,40(sp)
    80006040:	02813023          	sd	s0,32(sp)
    80006044:	00913c23          	sd	s1,24(sp)
    80006048:	01213823          	sd	s2,16(sp)
    8000604c:	01313423          	sd	s3,8(sp)
    80006050:	01413023          	sd	s4,0(sp)
    80006054:	03010413          	addi	s0,sp,48
    80006058:	00050993          	mv	s3,a0
    8000605c:	00058a13          	mv	s4,a1
    LOCK();
    80006060:	00100613          	li	a2,1
    80006064:	00000593          	li	a1,0
    80006068:	00007517          	auipc	a0,0x7
    8000606c:	d0050513          	addi	a0,a0,-768 # 8000cd68 <lockPrint>
    80006070:	ffffb097          	auipc	ra,0xffffb
    80006074:	4cc080e7          	jalr	1228(ra) # 8000153c <copy_and_swap>
    80006078:	00050863          	beqz	a0,80006088 <_Z9getStringPci+0x50>
    8000607c:	ffffb097          	auipc	ra,0xffffb
    80006080:	66c080e7          	jalr	1644(ra) # 800016e8 <_Z15thread_dispatchv>
    80006084:	fddff06f          	j	80006060 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80006088:	00000913          	li	s2,0
    8000608c:	00090493          	mv	s1,s2
    80006090:	0019091b          	addiw	s2,s2,1
    80006094:	03495a63          	bge	s2,s4,800060c8 <_Z9getStringPci+0x90>
        cc = getc();
    80006098:	ffffb097          	auipc	ra,0xffffb
    8000609c:	7c8080e7          	jalr	1992(ra) # 80001860 <_Z4getcv>
        if(cc < 1)
    800060a0:	02050463          	beqz	a0,800060c8 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    800060a4:	009984b3          	add	s1,s3,s1
    800060a8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800060ac:	00a00793          	li	a5,10
    800060b0:	00f50a63          	beq	a0,a5,800060c4 <_Z9getStringPci+0x8c>
    800060b4:	00d00793          	li	a5,13
    800060b8:	fcf51ae3          	bne	a0,a5,8000608c <_Z9getStringPci+0x54>
        buf[i++] = c;
    800060bc:	00090493          	mv	s1,s2
    800060c0:	0080006f          	j	800060c8 <_Z9getStringPci+0x90>
    800060c4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800060c8:	009984b3          	add	s1,s3,s1
    800060cc:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800060d0:	00000613          	li	a2,0
    800060d4:	00100593          	li	a1,1
    800060d8:	00007517          	auipc	a0,0x7
    800060dc:	c9050513          	addi	a0,a0,-880 # 8000cd68 <lockPrint>
    800060e0:	ffffb097          	auipc	ra,0xffffb
    800060e4:	45c080e7          	jalr	1116(ra) # 8000153c <copy_and_swap>
    800060e8:	fe0514e3          	bnez	a0,800060d0 <_Z9getStringPci+0x98>
    return buf;
}
    800060ec:	00098513          	mv	a0,s3
    800060f0:	02813083          	ld	ra,40(sp)
    800060f4:	02013403          	ld	s0,32(sp)
    800060f8:	01813483          	ld	s1,24(sp)
    800060fc:	01013903          	ld	s2,16(sp)
    80006100:	00813983          	ld	s3,8(sp)
    80006104:	00013a03          	ld	s4,0(sp)
    80006108:	03010113          	addi	sp,sp,48
    8000610c:	00008067          	ret

0000000080006110 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80006110:	ff010113          	addi	sp,sp,-16
    80006114:	00813423          	sd	s0,8(sp)
    80006118:	01010413          	addi	s0,sp,16
    8000611c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80006120:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80006124:	0006c603          	lbu	a2,0(a3)
    80006128:	fd06071b          	addiw	a4,a2,-48
    8000612c:	0ff77713          	andi	a4,a4,255
    80006130:	00900793          	li	a5,9
    80006134:	02e7e063          	bltu	a5,a4,80006154 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80006138:	0025179b          	slliw	a5,a0,0x2
    8000613c:	00a787bb          	addw	a5,a5,a0
    80006140:	0017979b          	slliw	a5,a5,0x1
    80006144:	00168693          	addi	a3,a3,1
    80006148:	00c787bb          	addw	a5,a5,a2
    8000614c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80006150:	fd5ff06f          	j	80006124 <_Z11stringToIntPKc+0x14>
    return n;
}
    80006154:	00813403          	ld	s0,8(sp)
    80006158:	01010113          	addi	sp,sp,16
    8000615c:	00008067          	ret

0000000080006160 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80006160:	fc010113          	addi	sp,sp,-64
    80006164:	02113c23          	sd	ra,56(sp)
    80006168:	02813823          	sd	s0,48(sp)
    8000616c:	02913423          	sd	s1,40(sp)
    80006170:	03213023          	sd	s2,32(sp)
    80006174:	01313c23          	sd	s3,24(sp)
    80006178:	04010413          	addi	s0,sp,64
    8000617c:	00050493          	mv	s1,a0
    80006180:	00058913          	mv	s2,a1
    80006184:	00060993          	mv	s3,a2
    LOCK();
    80006188:	00100613          	li	a2,1
    8000618c:	00000593          	li	a1,0
    80006190:	00007517          	auipc	a0,0x7
    80006194:	bd850513          	addi	a0,a0,-1064 # 8000cd68 <lockPrint>
    80006198:	ffffb097          	auipc	ra,0xffffb
    8000619c:	3a4080e7          	jalr	932(ra) # 8000153c <copy_and_swap>
    800061a0:	00050863          	beqz	a0,800061b0 <_Z8printIntiii+0x50>
    800061a4:	ffffb097          	auipc	ra,0xffffb
    800061a8:	544080e7          	jalr	1348(ra) # 800016e8 <_Z15thread_dispatchv>
    800061ac:	fddff06f          	j	80006188 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800061b0:	00098463          	beqz	s3,800061b8 <_Z8printIntiii+0x58>
    800061b4:	0804c463          	bltz	s1,8000623c <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800061b8:	0004851b          	sext.w	a0,s1
    neg = 0;
    800061bc:	00000593          	li	a1,0
    }

    i = 0;
    800061c0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800061c4:	0009079b          	sext.w	a5,s2
    800061c8:	0325773b          	remuw	a4,a0,s2
    800061cc:	00048613          	mv	a2,s1
    800061d0:	0014849b          	addiw	s1,s1,1
    800061d4:	02071693          	slli	a3,a4,0x20
    800061d8:	0206d693          	srli	a3,a3,0x20
    800061dc:	00007717          	auipc	a4,0x7
    800061e0:	9fc70713          	addi	a4,a4,-1540 # 8000cbd8 <digits>
    800061e4:	00d70733          	add	a4,a4,a3
    800061e8:	00074683          	lbu	a3,0(a4)
    800061ec:	fd040713          	addi	a4,s0,-48
    800061f0:	00c70733          	add	a4,a4,a2
    800061f4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800061f8:	0005071b          	sext.w	a4,a0
    800061fc:	0325553b          	divuw	a0,a0,s2
    80006200:	fcf772e3          	bgeu	a4,a5,800061c4 <_Z8printIntiii+0x64>
    if(neg)
    80006204:	00058c63          	beqz	a1,8000621c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80006208:	fd040793          	addi	a5,s0,-48
    8000620c:	009784b3          	add	s1,a5,s1
    80006210:	02d00793          	li	a5,45
    80006214:	fef48823          	sb	a5,-16(s1)
    80006218:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000621c:	fff4849b          	addiw	s1,s1,-1
    80006220:	0204c463          	bltz	s1,80006248 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80006224:	fd040793          	addi	a5,s0,-48
    80006228:	009787b3          	add	a5,a5,s1
    8000622c:	ff07c503          	lbu	a0,-16(a5)
    80006230:	ffffb097          	auipc	ra,0xffffb
    80006234:	664080e7          	jalr	1636(ra) # 80001894 <_Z4putcc>
    80006238:	fe5ff06f          	j	8000621c <_Z8printIntiii+0xbc>
        x = -xx;
    8000623c:	4090053b          	negw	a0,s1
        neg = 1;
    80006240:	00100593          	li	a1,1
        x = -xx;
    80006244:	f7dff06f          	j	800061c0 <_Z8printIntiii+0x60>

    UNLOCK();
    80006248:	00000613          	li	a2,0
    8000624c:	00100593          	li	a1,1
    80006250:	00007517          	auipc	a0,0x7
    80006254:	b1850513          	addi	a0,a0,-1256 # 8000cd68 <lockPrint>
    80006258:	ffffb097          	auipc	ra,0xffffb
    8000625c:	2e4080e7          	jalr	740(ra) # 8000153c <copy_and_swap>
    80006260:	fe0514e3          	bnez	a0,80006248 <_Z8printIntiii+0xe8>
    80006264:	03813083          	ld	ra,56(sp)
    80006268:	03013403          	ld	s0,48(sp)
    8000626c:	02813483          	ld	s1,40(sp)
    80006270:	02013903          	ld	s2,32(sp)
    80006274:	01813983          	ld	s3,24(sp)
    80006278:	04010113          	addi	sp,sp,64
    8000627c:	00008067          	ret

0000000080006280 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006280:	fd010113          	addi	sp,sp,-48
    80006284:	02113423          	sd	ra,40(sp)
    80006288:	02813023          	sd	s0,32(sp)
    8000628c:	00913c23          	sd	s1,24(sp)
    80006290:	01213823          	sd	s2,16(sp)
    80006294:	01313423          	sd	s3,8(sp)
    80006298:	03010413          	addi	s0,sp,48
    8000629c:	00050493          	mv	s1,a0
    800062a0:	00058913          	mv	s2,a1
    800062a4:	0015879b          	addiw	a5,a1,1
    800062a8:	0007851b          	sext.w	a0,a5
    800062ac:	00f4a023          	sw	a5,0(s1)
    800062b0:	0004a823          	sw	zero,16(s1)
    800062b4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800062b8:	00251513          	slli	a0,a0,0x2
    800062bc:	ffffb097          	auipc	ra,0xffffb
    800062c0:	2a0080e7          	jalr	672(ra) # 8000155c <_Z9mem_allocm>
    800062c4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800062c8:	01000513          	li	a0,16
    800062cc:	ffffc097          	auipc	ra,0xffffc
    800062d0:	afc080e7          	jalr	-1284(ra) # 80001dc8 <_Znwm>
    800062d4:	00050993          	mv	s3,a0
    800062d8:	00000593          	li	a1,0
    800062dc:	ffffc097          	auipc	ra,0xffffc
    800062e0:	dcc080e7          	jalr	-564(ra) # 800020a8 <_ZN9SemaphoreC1Ej>
    800062e4:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800062e8:	01000513          	li	a0,16
    800062ec:	ffffc097          	auipc	ra,0xffffc
    800062f0:	adc080e7          	jalr	-1316(ra) # 80001dc8 <_Znwm>
    800062f4:	00050993          	mv	s3,a0
    800062f8:	00090593          	mv	a1,s2
    800062fc:	ffffc097          	auipc	ra,0xffffc
    80006300:	dac080e7          	jalr	-596(ra) # 800020a8 <_ZN9SemaphoreC1Ej>
    80006304:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80006308:	01000513          	li	a0,16
    8000630c:	ffffc097          	auipc	ra,0xffffc
    80006310:	abc080e7          	jalr	-1348(ra) # 80001dc8 <_Znwm>
    80006314:	00050913          	mv	s2,a0
    80006318:	00100593          	li	a1,1
    8000631c:	ffffc097          	auipc	ra,0xffffc
    80006320:	d8c080e7          	jalr	-628(ra) # 800020a8 <_ZN9SemaphoreC1Ej>
    80006324:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80006328:	01000513          	li	a0,16
    8000632c:	ffffc097          	auipc	ra,0xffffc
    80006330:	a9c080e7          	jalr	-1380(ra) # 80001dc8 <_Znwm>
    80006334:	00050913          	mv	s2,a0
    80006338:	00100593          	li	a1,1
    8000633c:	ffffc097          	auipc	ra,0xffffc
    80006340:	d6c080e7          	jalr	-660(ra) # 800020a8 <_ZN9SemaphoreC1Ej>
    80006344:	0324b823          	sd	s2,48(s1)
}
    80006348:	02813083          	ld	ra,40(sp)
    8000634c:	02013403          	ld	s0,32(sp)
    80006350:	01813483          	ld	s1,24(sp)
    80006354:	01013903          	ld	s2,16(sp)
    80006358:	00813983          	ld	s3,8(sp)
    8000635c:	03010113          	addi	sp,sp,48
    80006360:	00008067          	ret
    80006364:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80006368:	00098513          	mv	a0,s3
    8000636c:	ffffc097          	auipc	ra,0xffffc
    80006370:	aac080e7          	jalr	-1364(ra) # 80001e18 <_ZdlPv>
    80006374:	00048513          	mv	a0,s1
    80006378:	00008097          	auipc	ra,0x8
    8000637c:	ad0080e7          	jalr	-1328(ra) # 8000de48 <_Unwind_Resume>
    80006380:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80006384:	00098513          	mv	a0,s3
    80006388:	ffffc097          	auipc	ra,0xffffc
    8000638c:	a90080e7          	jalr	-1392(ra) # 80001e18 <_ZdlPv>
    80006390:	00048513          	mv	a0,s1
    80006394:	00008097          	auipc	ra,0x8
    80006398:	ab4080e7          	jalr	-1356(ra) # 8000de48 <_Unwind_Resume>
    8000639c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800063a0:	00090513          	mv	a0,s2
    800063a4:	ffffc097          	auipc	ra,0xffffc
    800063a8:	a74080e7          	jalr	-1420(ra) # 80001e18 <_ZdlPv>
    800063ac:	00048513          	mv	a0,s1
    800063b0:	00008097          	auipc	ra,0x8
    800063b4:	a98080e7          	jalr	-1384(ra) # 8000de48 <_Unwind_Resume>
    800063b8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800063bc:	00090513          	mv	a0,s2
    800063c0:	ffffc097          	auipc	ra,0xffffc
    800063c4:	a58080e7          	jalr	-1448(ra) # 80001e18 <_ZdlPv>
    800063c8:	00048513          	mv	a0,s1
    800063cc:	00008097          	auipc	ra,0x8
    800063d0:	a7c080e7          	jalr	-1412(ra) # 8000de48 <_Unwind_Resume>

00000000800063d4 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800063d4:	fe010113          	addi	sp,sp,-32
    800063d8:	00113c23          	sd	ra,24(sp)
    800063dc:	00813823          	sd	s0,16(sp)
    800063e0:	00913423          	sd	s1,8(sp)
    800063e4:	01213023          	sd	s2,0(sp)
    800063e8:	02010413          	addi	s0,sp,32
    800063ec:	00050493          	mv	s1,a0
    800063f0:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800063f4:	01853503          	ld	a0,24(a0)
    800063f8:	ffffc097          	auipc	ra,0xffffc
    800063fc:	c58080e7          	jalr	-936(ra) # 80002050 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80006400:	0304b503          	ld	a0,48(s1)
    80006404:	ffffc097          	auipc	ra,0xffffc
    80006408:	c4c080e7          	jalr	-948(ra) # 80002050 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000640c:	0084b783          	ld	a5,8(s1)
    80006410:	0144a703          	lw	a4,20(s1)
    80006414:	00271713          	slli	a4,a4,0x2
    80006418:	00e787b3          	add	a5,a5,a4
    8000641c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006420:	0144a783          	lw	a5,20(s1)
    80006424:	0017879b          	addiw	a5,a5,1
    80006428:	0004a703          	lw	a4,0(s1)
    8000642c:	02e7e7bb          	remw	a5,a5,a4
    80006430:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80006434:	0304b503          	ld	a0,48(s1)
    80006438:	ffffc097          	auipc	ra,0xffffc
    8000643c:	c44080e7          	jalr	-956(ra) # 8000207c <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80006440:	0204b503          	ld	a0,32(s1)
    80006444:	ffffc097          	auipc	ra,0xffffc
    80006448:	c38080e7          	jalr	-968(ra) # 8000207c <_ZN9Semaphore6signalEv>

}
    8000644c:	01813083          	ld	ra,24(sp)
    80006450:	01013403          	ld	s0,16(sp)
    80006454:	00813483          	ld	s1,8(sp)
    80006458:	00013903          	ld	s2,0(sp)
    8000645c:	02010113          	addi	sp,sp,32
    80006460:	00008067          	ret

0000000080006464 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80006464:	fe010113          	addi	sp,sp,-32
    80006468:	00113c23          	sd	ra,24(sp)
    8000646c:	00813823          	sd	s0,16(sp)
    80006470:	00913423          	sd	s1,8(sp)
    80006474:	01213023          	sd	s2,0(sp)
    80006478:	02010413          	addi	s0,sp,32
    8000647c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80006480:	02053503          	ld	a0,32(a0)
    80006484:	ffffc097          	auipc	ra,0xffffc
    80006488:	bcc080e7          	jalr	-1076(ra) # 80002050 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000648c:	0284b503          	ld	a0,40(s1)
    80006490:	ffffc097          	auipc	ra,0xffffc
    80006494:	bc0080e7          	jalr	-1088(ra) # 80002050 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80006498:	0084b703          	ld	a4,8(s1)
    8000649c:	0104a783          	lw	a5,16(s1)
    800064a0:	00279693          	slli	a3,a5,0x2
    800064a4:	00d70733          	add	a4,a4,a3
    800064a8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800064ac:	0017879b          	addiw	a5,a5,1
    800064b0:	0004a703          	lw	a4,0(s1)
    800064b4:	02e7e7bb          	remw	a5,a5,a4
    800064b8:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800064bc:	0284b503          	ld	a0,40(s1)
    800064c0:	ffffc097          	auipc	ra,0xffffc
    800064c4:	bbc080e7          	jalr	-1092(ra) # 8000207c <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800064c8:	0184b503          	ld	a0,24(s1)
    800064cc:	ffffc097          	auipc	ra,0xffffc
    800064d0:	bb0080e7          	jalr	-1104(ra) # 8000207c <_ZN9Semaphore6signalEv>

    return ret;
}
    800064d4:	00090513          	mv	a0,s2
    800064d8:	01813083          	ld	ra,24(sp)
    800064dc:	01013403          	ld	s0,16(sp)
    800064e0:	00813483          	ld	s1,8(sp)
    800064e4:	00013903          	ld	s2,0(sp)
    800064e8:	02010113          	addi	sp,sp,32
    800064ec:	00008067          	ret

00000000800064f0 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800064f0:	fe010113          	addi	sp,sp,-32
    800064f4:	00113c23          	sd	ra,24(sp)
    800064f8:	00813823          	sd	s0,16(sp)
    800064fc:	00913423          	sd	s1,8(sp)
    80006500:	01213023          	sd	s2,0(sp)
    80006504:	02010413          	addi	s0,sp,32
    80006508:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000650c:	02853503          	ld	a0,40(a0)
    80006510:	ffffc097          	auipc	ra,0xffffc
    80006514:	b40080e7          	jalr	-1216(ra) # 80002050 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80006518:	0304b503          	ld	a0,48(s1)
    8000651c:	ffffc097          	auipc	ra,0xffffc
    80006520:	b34080e7          	jalr	-1228(ra) # 80002050 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80006524:	0144a783          	lw	a5,20(s1)
    80006528:	0104a903          	lw	s2,16(s1)
    8000652c:	0327ce63          	blt	a5,s2,80006568 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80006530:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80006534:	0304b503          	ld	a0,48(s1)
    80006538:	ffffc097          	auipc	ra,0xffffc
    8000653c:	b44080e7          	jalr	-1212(ra) # 8000207c <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80006540:	0284b503          	ld	a0,40(s1)
    80006544:	ffffc097          	auipc	ra,0xffffc
    80006548:	b38080e7          	jalr	-1224(ra) # 8000207c <_ZN9Semaphore6signalEv>

    return ret;
}
    8000654c:	00090513          	mv	a0,s2
    80006550:	01813083          	ld	ra,24(sp)
    80006554:	01013403          	ld	s0,16(sp)
    80006558:	00813483          	ld	s1,8(sp)
    8000655c:	00013903          	ld	s2,0(sp)
    80006560:	02010113          	addi	sp,sp,32
    80006564:	00008067          	ret
        ret = cap - head + tail;
    80006568:	0004a703          	lw	a4,0(s1)
    8000656c:	4127093b          	subw	s2,a4,s2
    80006570:	00f9093b          	addw	s2,s2,a5
    80006574:	fc1ff06f          	j	80006534 <_ZN9BufferCPP6getCntEv+0x44>

0000000080006578 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80006578:	fe010113          	addi	sp,sp,-32
    8000657c:	00113c23          	sd	ra,24(sp)
    80006580:	00813823          	sd	s0,16(sp)
    80006584:	00913423          	sd	s1,8(sp)
    80006588:	02010413          	addi	s0,sp,32
    8000658c:	00050493          	mv	s1,a0
    Console::putc('\n');
    80006590:	00a00513          	li	a0,10
    80006594:	ffffc097          	auipc	ra,0xffffc
    80006598:	a94080e7          	jalr	-1388(ra) # 80002028 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000659c:	00004517          	auipc	a0,0x4
    800065a0:	cf450513          	addi	a0,a0,-780 # 8000a290 <CONSOLE_STATUS+0x280>
    800065a4:	00000097          	auipc	ra,0x0
    800065a8:	a0c080e7          	jalr	-1524(ra) # 80005fb0 <_Z11printStringPKc>
    while (getCnt()) {
    800065ac:	00048513          	mv	a0,s1
    800065b0:	00000097          	auipc	ra,0x0
    800065b4:	f40080e7          	jalr	-192(ra) # 800064f0 <_ZN9BufferCPP6getCntEv>
    800065b8:	02050c63          	beqz	a0,800065f0 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800065bc:	0084b783          	ld	a5,8(s1)
    800065c0:	0104a703          	lw	a4,16(s1)
    800065c4:	00271713          	slli	a4,a4,0x2
    800065c8:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800065cc:	0007c503          	lbu	a0,0(a5)
    800065d0:	ffffc097          	auipc	ra,0xffffc
    800065d4:	a58080e7          	jalr	-1448(ra) # 80002028 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800065d8:	0104a783          	lw	a5,16(s1)
    800065dc:	0017879b          	addiw	a5,a5,1
    800065e0:	0004a703          	lw	a4,0(s1)
    800065e4:	02e7e7bb          	remw	a5,a5,a4
    800065e8:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800065ec:	fc1ff06f          	j	800065ac <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800065f0:	02100513          	li	a0,33
    800065f4:	ffffc097          	auipc	ra,0xffffc
    800065f8:	a34080e7          	jalr	-1484(ra) # 80002028 <_ZN7Console4putcEc>
    Console::putc('\n');
    800065fc:	00a00513          	li	a0,10
    80006600:	ffffc097          	auipc	ra,0xffffc
    80006604:	a28080e7          	jalr	-1496(ra) # 80002028 <_ZN7Console4putcEc>
    mem_free(buffer);
    80006608:	0084b503          	ld	a0,8(s1)
    8000660c:	ffffb097          	auipc	ra,0xffffb
    80006610:	f9c080e7          	jalr	-100(ra) # 800015a8 <_Z8mem_freePv>
    delete itemAvailable;
    80006614:	0204b503          	ld	a0,32(s1)
    80006618:	00050863          	beqz	a0,80006628 <_ZN9BufferCPPD1Ev+0xb0>
    8000661c:	00053783          	ld	a5,0(a0)
    80006620:	0087b783          	ld	a5,8(a5)
    80006624:	000780e7          	jalr	a5
    delete spaceAvailable;
    80006628:	0184b503          	ld	a0,24(s1)
    8000662c:	00050863          	beqz	a0,8000663c <_ZN9BufferCPPD1Ev+0xc4>
    80006630:	00053783          	ld	a5,0(a0)
    80006634:	0087b783          	ld	a5,8(a5)
    80006638:	000780e7          	jalr	a5
    delete mutexTail;
    8000663c:	0304b503          	ld	a0,48(s1)
    80006640:	00050863          	beqz	a0,80006650 <_ZN9BufferCPPD1Ev+0xd8>
    80006644:	00053783          	ld	a5,0(a0)
    80006648:	0087b783          	ld	a5,8(a5)
    8000664c:	000780e7          	jalr	a5
    delete mutexHead;
    80006650:	0284b503          	ld	a0,40(s1)
    80006654:	00050863          	beqz	a0,80006664 <_ZN9BufferCPPD1Ev+0xec>
    80006658:	00053783          	ld	a5,0(a0)
    8000665c:	0087b783          	ld	a5,8(a5)
    80006660:	000780e7          	jalr	a5
}
    80006664:	01813083          	ld	ra,24(sp)
    80006668:	01013403          	ld	s0,16(sp)
    8000666c:	00813483          	ld	s1,8(sp)
    80006670:	02010113          	addi	sp,sp,32
    80006674:	00008067          	ret

0000000080006678 <_Z8userMainPv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain(void* args) {
    80006678:	fe010113          	addi	sp,sp,-32
    8000667c:	00113c23          	sd	ra,24(sp)
    80006680:	00813823          	sd	s0,16(sp)
    80006684:	00913423          	sd	s1,8(sp)
    80006688:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    8000668c:	00004517          	auipc	a0,0x4
    80006690:	c1c50513          	addi	a0,a0,-996 # 8000a2a8 <CONSOLE_STATUS+0x298>
    80006694:	00000097          	auipc	ra,0x0
    80006698:	91c080e7          	jalr	-1764(ra) # 80005fb0 <_Z11printStringPKc>
    int test = getc() - '0';
    8000669c:	ffffb097          	auipc	ra,0xffffb
    800066a0:	1c4080e7          	jalr	452(ra) # 80001860 <_Z4getcv>
    800066a4:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    800066a8:	ffffb097          	auipc	ra,0xffffb
    800066ac:	1b8080e7          	jalr	440(ra) # 80001860 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800066b0:	00700793          	li	a5,7
    800066b4:	1097e263          	bltu	a5,s1,800067b8 <_Z8userMainPv+0x140>
    800066b8:	00249493          	slli	s1,s1,0x2
    800066bc:	00004717          	auipc	a4,0x4
    800066c0:	e4470713          	addi	a4,a4,-444 # 8000a500 <CONSOLE_STATUS+0x4f0>
    800066c4:	00e484b3          	add	s1,s1,a4
    800066c8:	0004a783          	lw	a5,0(s1)
    800066cc:	00e787b3          	add	a5,a5,a4
    800066d0:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    800066d4:	fffff097          	auipc	ra,0xfffff
    800066d8:	f54080e7          	jalr	-172(ra) # 80005628 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800066dc:	00004517          	auipc	a0,0x4
    800066e0:	bec50513          	addi	a0,a0,-1044 # 8000a2c8 <CONSOLE_STATUS+0x2b8>
    800066e4:	00000097          	auipc	ra,0x0
    800066e8:	8cc080e7          	jalr	-1844(ra) # 80005fb0 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800066ec:	01813083          	ld	ra,24(sp)
    800066f0:	01013403          	ld	s0,16(sp)
    800066f4:	00813483          	ld	s1,8(sp)
    800066f8:	02010113          	addi	sp,sp,32
    800066fc:	00008067          	ret
            Threads_CPP_API_test();
    80006700:	ffffe097          	auipc	ra,0xffffe
    80006704:	e08080e7          	jalr	-504(ra) # 80004508 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80006708:	00004517          	auipc	a0,0x4
    8000670c:	c0050513          	addi	a0,a0,-1024 # 8000a308 <CONSOLE_STATUS+0x2f8>
    80006710:	00000097          	auipc	ra,0x0
    80006714:	8a0080e7          	jalr	-1888(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80006718:	fd5ff06f          	j	800066ec <_Z8userMainPv+0x74>
            producerConsumer_C_API();
    8000671c:	ffffd097          	auipc	ra,0xffffd
    80006720:	640080e7          	jalr	1600(ra) # 80003d5c <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80006724:	00004517          	auipc	a0,0x4
    80006728:	c2450513          	addi	a0,a0,-988 # 8000a348 <CONSOLE_STATUS+0x338>
    8000672c:	00000097          	auipc	ra,0x0
    80006730:	884080e7          	jalr	-1916(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80006734:	fb9ff06f          	j	800066ec <_Z8userMainPv+0x74>
            producerConsumer_CPP_Sync_API();
    80006738:	fffff097          	auipc	ra,0xfffff
    8000673c:	234080e7          	jalr	564(ra) # 8000596c <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80006740:	00004517          	auipc	a0,0x4
    80006744:	c5850513          	addi	a0,a0,-936 # 8000a398 <CONSOLE_STATUS+0x388>
    80006748:	00000097          	auipc	ra,0x0
    8000674c:	868080e7          	jalr	-1944(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80006750:	f9dff06f          	j	800066ec <_Z8userMainPv+0x74>
            testSleeping();
    80006754:	00000097          	auipc	ra,0x0
    80006758:	11c080e7          	jalr	284(ra) # 80006870 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    8000675c:	00004517          	auipc	a0,0x4
    80006760:	c9450513          	addi	a0,a0,-876 # 8000a3f0 <CONSOLE_STATUS+0x3e0>
    80006764:	00000097          	auipc	ra,0x0
    80006768:	84c080e7          	jalr	-1972(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    8000676c:	f81ff06f          	j	800066ec <_Z8userMainPv+0x74>
            testConsumerProducer();
    80006770:	ffffe097          	auipc	ra,0xffffe
    80006774:	258080e7          	jalr	600(ra) # 800049c8 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80006778:	00004517          	auipc	a0,0x4
    8000677c:	ca850513          	addi	a0,a0,-856 # 8000a420 <CONSOLE_STATUS+0x410>
    80006780:	00000097          	auipc	ra,0x0
    80006784:	830080e7          	jalr	-2000(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    80006788:	f65ff06f          	j	800066ec <_Z8userMainPv+0x74>
            System_Mode_test();
    8000678c:	00000097          	auipc	ra,0x0
    80006790:	658080e7          	jalr	1624(ra) # 80006de4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80006794:	00004517          	auipc	a0,0x4
    80006798:	ccc50513          	addi	a0,a0,-820 # 8000a460 <CONSOLE_STATUS+0x450>
    8000679c:	00000097          	auipc	ra,0x0
    800067a0:	814080e7          	jalr	-2028(ra) # 80005fb0 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800067a4:	00004517          	auipc	a0,0x4
    800067a8:	cdc50513          	addi	a0,a0,-804 # 8000a480 <CONSOLE_STATUS+0x470>
    800067ac:	00000097          	auipc	ra,0x0
    800067b0:	804080e7          	jalr	-2044(ra) # 80005fb0 <_Z11printStringPKc>
            break;
    800067b4:	f39ff06f          	j	800066ec <_Z8userMainPv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    800067b8:	00004517          	auipc	a0,0x4
    800067bc:	d2050513          	addi	a0,a0,-736 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    800067c0:	fffff097          	auipc	ra,0xfffff
    800067c4:	7f0080e7          	jalr	2032(ra) # 80005fb0 <_Z11printStringPKc>
    800067c8:	f25ff06f          	j	800066ec <_Z8userMainPv+0x74>

00000000800067cc <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    800067cc:	fe010113          	addi	sp,sp,-32
    800067d0:	00113c23          	sd	ra,24(sp)
    800067d4:	00813823          	sd	s0,16(sp)
    800067d8:	00913423          	sd	s1,8(sp)
    800067dc:	01213023          	sd	s2,0(sp)
    800067e0:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    800067e4:	00053903          	ld	s2,0(a0)
    int i = 6;
    800067e8:	00600493          	li	s1,6
    while (--i > 0) {
    800067ec:	fff4849b          	addiw	s1,s1,-1
    800067f0:	04905463          	blez	s1,80006838 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    800067f4:	00004517          	auipc	a0,0x4
    800067f8:	d2c50513          	addi	a0,a0,-724 # 8000a520 <CONSOLE_STATUS+0x510>
    800067fc:	fffff097          	auipc	ra,0xfffff
    80006800:	7b4080e7          	jalr	1972(ra) # 80005fb0 <_Z11printStringPKc>
        printInt(sleep_time);
    80006804:	00000613          	li	a2,0
    80006808:	00a00593          	li	a1,10
    8000680c:	0009051b          	sext.w	a0,s2
    80006810:	00000097          	auipc	ra,0x0
    80006814:	950080e7          	jalr	-1712(ra) # 80006160 <_Z8printIntiii>
        printString(" !\n");
    80006818:	00004517          	auipc	a0,0x4
    8000681c:	d1050513          	addi	a0,a0,-752 # 8000a528 <CONSOLE_STATUS+0x518>
    80006820:	fffff097          	auipc	ra,0xfffff
    80006824:	790080e7          	jalr	1936(ra) # 80005fb0 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80006828:	00090513          	mv	a0,s2
    8000682c:	ffffb097          	auipc	ra,0xffffb
    80006830:	ffc080e7          	jalr	-4(ra) # 80001828 <_Z10time_sleepm>
    while (--i > 0) {
    80006834:	fb9ff06f          	j	800067ec <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80006838:	00a00793          	li	a5,10
    8000683c:	02f95933          	divu	s2,s2,a5
    80006840:	fff90913          	addi	s2,s2,-1
    80006844:	00006797          	auipc	a5,0x6
    80006848:	52c78793          	addi	a5,a5,1324 # 8000cd70 <_ZL8finished>
    8000684c:	01278933          	add	s2,a5,s2
    80006850:	00100793          	li	a5,1
    80006854:	00f90023          	sb	a5,0(s2)
}
    80006858:	01813083          	ld	ra,24(sp)
    8000685c:	01013403          	ld	s0,16(sp)
    80006860:	00813483          	ld	s1,8(sp)
    80006864:	00013903          	ld	s2,0(sp)
    80006868:	02010113          	addi	sp,sp,32
    8000686c:	00008067          	ret

0000000080006870 <_Z12testSleepingv>:

void testSleeping() {
    80006870:	fc010113          	addi	sp,sp,-64
    80006874:	02113c23          	sd	ra,56(sp)
    80006878:	02813823          	sd	s0,48(sp)
    8000687c:	02913423          	sd	s1,40(sp)
    80006880:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80006884:	00a00793          	li	a5,10
    80006888:	fcf43823          	sd	a5,-48(s0)
    8000688c:	01400793          	li	a5,20
    80006890:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006894:	00000493          	li	s1,0
    80006898:	02c0006f          	j	800068c4 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000689c:	00349793          	slli	a5,s1,0x3
    800068a0:	fd040613          	addi	a2,s0,-48
    800068a4:	00f60633          	add	a2,a2,a5
    800068a8:	00000597          	auipc	a1,0x0
    800068ac:	f2458593          	addi	a1,a1,-220 # 800067cc <_ZL9sleepyRunPv>
    800068b0:	fc040513          	addi	a0,s0,-64
    800068b4:	00f50533          	add	a0,a0,a5
    800068b8:	ffffb097          	auipc	ra,0xffffb
    800068bc:	d28080e7          	jalr	-728(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800068c0:	0014849b          	addiw	s1,s1,1
    800068c4:	00100793          	li	a5,1
    800068c8:	fc97dae3          	bge	a5,s1,8000689c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800068cc:	00006797          	auipc	a5,0x6
    800068d0:	4a47c783          	lbu	a5,1188(a5) # 8000cd70 <_ZL8finished>
    800068d4:	fe078ce3          	beqz	a5,800068cc <_Z12testSleepingv+0x5c>
    800068d8:	00006797          	auipc	a5,0x6
    800068dc:	4997c783          	lbu	a5,1177(a5) # 8000cd71 <_ZL8finished+0x1>
    800068e0:	fe0786e3          	beqz	a5,800068cc <_Z12testSleepingv+0x5c>
}
    800068e4:	03813083          	ld	ra,56(sp)
    800068e8:	03013403          	ld	s0,48(sp)
    800068ec:	02813483          	ld	s1,40(sp)
    800068f0:	04010113          	addi	sp,sp,64
    800068f4:	00008067          	ret

00000000800068f8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800068f8:	fe010113          	addi	sp,sp,-32
    800068fc:	00113c23          	sd	ra,24(sp)
    80006900:	00813823          	sd	s0,16(sp)
    80006904:	00913423          	sd	s1,8(sp)
    80006908:	01213023          	sd	s2,0(sp)
    8000690c:	02010413          	addi	s0,sp,32
    80006910:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80006914:	00100793          	li	a5,1
    80006918:	02a7f863          	bgeu	a5,a0,80006948 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000691c:	00a00793          	li	a5,10
    80006920:	02f577b3          	remu	a5,a0,a5
    80006924:	02078e63          	beqz	a5,80006960 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80006928:	fff48513          	addi	a0,s1,-1
    8000692c:	00000097          	auipc	ra,0x0
    80006930:	fcc080e7          	jalr	-52(ra) # 800068f8 <_ZL9fibonaccim>
    80006934:	00050913          	mv	s2,a0
    80006938:	ffe48513          	addi	a0,s1,-2
    8000693c:	00000097          	auipc	ra,0x0
    80006940:	fbc080e7          	jalr	-68(ra) # 800068f8 <_ZL9fibonaccim>
    80006944:	00a90533          	add	a0,s2,a0
}
    80006948:	01813083          	ld	ra,24(sp)
    8000694c:	01013403          	ld	s0,16(sp)
    80006950:	00813483          	ld	s1,8(sp)
    80006954:	00013903          	ld	s2,0(sp)
    80006958:	02010113          	addi	sp,sp,32
    8000695c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80006960:	ffffb097          	auipc	ra,0xffffb
    80006964:	d88080e7          	jalr	-632(ra) # 800016e8 <_Z15thread_dispatchv>
    80006968:	fc1ff06f          	j	80006928 <_ZL9fibonaccim+0x30>

000000008000696c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000696c:	fe010113          	addi	sp,sp,-32
    80006970:	00113c23          	sd	ra,24(sp)
    80006974:	00813823          	sd	s0,16(sp)
    80006978:	00913423          	sd	s1,8(sp)
    8000697c:	01213023          	sd	s2,0(sp)
    80006980:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80006984:	00a00493          	li	s1,10
    80006988:	0400006f          	j	800069c8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000698c:	00004517          	auipc	a0,0x4
    80006990:	86c50513          	addi	a0,a0,-1940 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80006994:	fffff097          	auipc	ra,0xfffff
    80006998:	61c080e7          	jalr	1564(ra) # 80005fb0 <_Z11printStringPKc>
    8000699c:	00000613          	li	a2,0
    800069a0:	00a00593          	li	a1,10
    800069a4:	00048513          	mv	a0,s1
    800069a8:	fffff097          	auipc	ra,0xfffff
    800069ac:	7b8080e7          	jalr	1976(ra) # 80006160 <_Z8printIntiii>
    800069b0:	00004517          	auipc	a0,0x4
    800069b4:	a3850513          	addi	a0,a0,-1480 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800069b8:	fffff097          	auipc	ra,0xfffff
    800069bc:	5f8080e7          	jalr	1528(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800069c0:	0014849b          	addiw	s1,s1,1
    800069c4:	0ff4f493          	andi	s1,s1,255
    800069c8:	00c00793          	li	a5,12
    800069cc:	fc97f0e3          	bgeu	a5,s1,8000698c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800069d0:	00004517          	auipc	a0,0x4
    800069d4:	83050513          	addi	a0,a0,-2000 # 8000a200 <CONSOLE_STATUS+0x1f0>
    800069d8:	fffff097          	auipc	ra,0xfffff
    800069dc:	5d8080e7          	jalr	1496(ra) # 80005fb0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800069e0:	00500313          	li	t1,5
    thread_dispatch();
    800069e4:	ffffb097          	auipc	ra,0xffffb
    800069e8:	d04080e7          	jalr	-764(ra) # 800016e8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800069ec:	01000513          	li	a0,16
    800069f0:	00000097          	auipc	ra,0x0
    800069f4:	f08080e7          	jalr	-248(ra) # 800068f8 <_ZL9fibonaccim>
    800069f8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800069fc:	00004517          	auipc	a0,0x4
    80006a00:	81450513          	addi	a0,a0,-2028 # 8000a210 <CONSOLE_STATUS+0x200>
    80006a04:	fffff097          	auipc	ra,0xfffff
    80006a08:	5ac080e7          	jalr	1452(ra) # 80005fb0 <_Z11printStringPKc>
    80006a0c:	00000613          	li	a2,0
    80006a10:	00a00593          	li	a1,10
    80006a14:	0009051b          	sext.w	a0,s2
    80006a18:	fffff097          	auipc	ra,0xfffff
    80006a1c:	748080e7          	jalr	1864(ra) # 80006160 <_Z8printIntiii>
    80006a20:	00004517          	auipc	a0,0x4
    80006a24:	9c850513          	addi	a0,a0,-1592 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006a28:	fffff097          	auipc	ra,0xfffff
    80006a2c:	588080e7          	jalr	1416(ra) # 80005fb0 <_Z11printStringPKc>
    80006a30:	0400006f          	j	80006a70 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006a34:	00003517          	auipc	a0,0x3
    80006a38:	7c450513          	addi	a0,a0,1988 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80006a3c:	fffff097          	auipc	ra,0xfffff
    80006a40:	574080e7          	jalr	1396(ra) # 80005fb0 <_Z11printStringPKc>
    80006a44:	00000613          	li	a2,0
    80006a48:	00a00593          	li	a1,10
    80006a4c:	00048513          	mv	a0,s1
    80006a50:	fffff097          	auipc	ra,0xfffff
    80006a54:	710080e7          	jalr	1808(ra) # 80006160 <_Z8printIntiii>
    80006a58:	00004517          	auipc	a0,0x4
    80006a5c:	99050513          	addi	a0,a0,-1648 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006a60:	fffff097          	auipc	ra,0xfffff
    80006a64:	550080e7          	jalr	1360(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80006a68:	0014849b          	addiw	s1,s1,1
    80006a6c:	0ff4f493          	andi	s1,s1,255
    80006a70:	00f00793          	li	a5,15
    80006a74:	fc97f0e3          	bgeu	a5,s1,80006a34 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80006a78:	00003517          	auipc	a0,0x3
    80006a7c:	7a850513          	addi	a0,a0,1960 # 8000a220 <CONSOLE_STATUS+0x210>
    80006a80:	fffff097          	auipc	ra,0xfffff
    80006a84:	530080e7          	jalr	1328(ra) # 80005fb0 <_Z11printStringPKc>
    finishedD = true;
    80006a88:	00100793          	li	a5,1
    80006a8c:	00006717          	auipc	a4,0x6
    80006a90:	2ef70323          	sb	a5,742(a4) # 8000cd72 <_ZL9finishedD>
    thread_dispatch();
    80006a94:	ffffb097          	auipc	ra,0xffffb
    80006a98:	c54080e7          	jalr	-940(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80006a9c:	01813083          	ld	ra,24(sp)
    80006aa0:	01013403          	ld	s0,16(sp)
    80006aa4:	00813483          	ld	s1,8(sp)
    80006aa8:	00013903          	ld	s2,0(sp)
    80006aac:	02010113          	addi	sp,sp,32
    80006ab0:	00008067          	ret

0000000080006ab4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80006ab4:	fe010113          	addi	sp,sp,-32
    80006ab8:	00113c23          	sd	ra,24(sp)
    80006abc:	00813823          	sd	s0,16(sp)
    80006ac0:	00913423          	sd	s1,8(sp)
    80006ac4:	01213023          	sd	s2,0(sp)
    80006ac8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80006acc:	00000493          	li	s1,0
    80006ad0:	0400006f          	j	80006b10 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80006ad4:	00003517          	auipc	a0,0x3
    80006ad8:	6f450513          	addi	a0,a0,1780 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80006adc:	fffff097          	auipc	ra,0xfffff
    80006ae0:	4d4080e7          	jalr	1236(ra) # 80005fb0 <_Z11printStringPKc>
    80006ae4:	00000613          	li	a2,0
    80006ae8:	00a00593          	li	a1,10
    80006aec:	00048513          	mv	a0,s1
    80006af0:	fffff097          	auipc	ra,0xfffff
    80006af4:	670080e7          	jalr	1648(ra) # 80006160 <_Z8printIntiii>
    80006af8:	00004517          	auipc	a0,0x4
    80006afc:	8f050513          	addi	a0,a0,-1808 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006b00:	fffff097          	auipc	ra,0xfffff
    80006b04:	4b0080e7          	jalr	1200(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80006b08:	0014849b          	addiw	s1,s1,1
    80006b0c:	0ff4f493          	andi	s1,s1,255
    80006b10:	00200793          	li	a5,2
    80006b14:	fc97f0e3          	bgeu	a5,s1,80006ad4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80006b18:	00003517          	auipc	a0,0x3
    80006b1c:	6b850513          	addi	a0,a0,1720 # 8000a1d0 <CONSOLE_STATUS+0x1c0>
    80006b20:	fffff097          	auipc	ra,0xfffff
    80006b24:	490080e7          	jalr	1168(ra) # 80005fb0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80006b28:	00700313          	li	t1,7
    thread_dispatch();
    80006b2c:	ffffb097          	auipc	ra,0xffffb
    80006b30:	bbc080e7          	jalr	-1092(ra) # 800016e8 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80006b34:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80006b38:	00003517          	auipc	a0,0x3
    80006b3c:	6a850513          	addi	a0,a0,1704 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    80006b40:	fffff097          	auipc	ra,0xfffff
    80006b44:	470080e7          	jalr	1136(ra) # 80005fb0 <_Z11printStringPKc>
    80006b48:	00000613          	li	a2,0
    80006b4c:	00a00593          	li	a1,10
    80006b50:	0009051b          	sext.w	a0,s2
    80006b54:	fffff097          	auipc	ra,0xfffff
    80006b58:	60c080e7          	jalr	1548(ra) # 80006160 <_Z8printIntiii>
    80006b5c:	00004517          	auipc	a0,0x4
    80006b60:	88c50513          	addi	a0,a0,-1908 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006b64:	fffff097          	auipc	ra,0xfffff
    80006b68:	44c080e7          	jalr	1100(ra) # 80005fb0 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80006b6c:	00c00513          	li	a0,12
    80006b70:	00000097          	auipc	ra,0x0
    80006b74:	d88080e7          	jalr	-632(ra) # 800068f8 <_ZL9fibonaccim>
    80006b78:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80006b7c:	00003517          	auipc	a0,0x3
    80006b80:	66c50513          	addi	a0,a0,1644 # 8000a1e8 <CONSOLE_STATUS+0x1d8>
    80006b84:	fffff097          	auipc	ra,0xfffff
    80006b88:	42c080e7          	jalr	1068(ra) # 80005fb0 <_Z11printStringPKc>
    80006b8c:	00000613          	li	a2,0
    80006b90:	00a00593          	li	a1,10
    80006b94:	0009051b          	sext.w	a0,s2
    80006b98:	fffff097          	auipc	ra,0xfffff
    80006b9c:	5c8080e7          	jalr	1480(ra) # 80006160 <_Z8printIntiii>
    80006ba0:	00004517          	auipc	a0,0x4
    80006ba4:	84850513          	addi	a0,a0,-1976 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006ba8:	fffff097          	auipc	ra,0xfffff
    80006bac:	408080e7          	jalr	1032(ra) # 80005fb0 <_Z11printStringPKc>
    80006bb0:	0400006f          	j	80006bf0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80006bb4:	00003517          	auipc	a0,0x3
    80006bb8:	61450513          	addi	a0,a0,1556 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80006bbc:	fffff097          	auipc	ra,0xfffff
    80006bc0:	3f4080e7          	jalr	1012(ra) # 80005fb0 <_Z11printStringPKc>
    80006bc4:	00000613          	li	a2,0
    80006bc8:	00a00593          	li	a1,10
    80006bcc:	00048513          	mv	a0,s1
    80006bd0:	fffff097          	auipc	ra,0xfffff
    80006bd4:	590080e7          	jalr	1424(ra) # 80006160 <_Z8printIntiii>
    80006bd8:	00004517          	auipc	a0,0x4
    80006bdc:	81050513          	addi	a0,a0,-2032 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006be0:	fffff097          	auipc	ra,0xfffff
    80006be4:	3d0080e7          	jalr	976(ra) # 80005fb0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80006be8:	0014849b          	addiw	s1,s1,1
    80006bec:	0ff4f493          	andi	s1,s1,255
    80006bf0:	00500793          	li	a5,5
    80006bf4:	fc97f0e3          	bgeu	a5,s1,80006bb4 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80006bf8:	00003517          	auipc	a0,0x3
    80006bfc:	5a850513          	addi	a0,a0,1448 # 8000a1a0 <CONSOLE_STATUS+0x190>
    80006c00:	fffff097          	auipc	ra,0xfffff
    80006c04:	3b0080e7          	jalr	944(ra) # 80005fb0 <_Z11printStringPKc>
    finishedC = true;
    80006c08:	00100793          	li	a5,1
    80006c0c:	00006717          	auipc	a4,0x6
    80006c10:	16f703a3          	sb	a5,359(a4) # 8000cd73 <_ZL9finishedC>
    thread_dispatch();
    80006c14:	ffffb097          	auipc	ra,0xffffb
    80006c18:	ad4080e7          	jalr	-1324(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80006c1c:	01813083          	ld	ra,24(sp)
    80006c20:	01013403          	ld	s0,16(sp)
    80006c24:	00813483          	ld	s1,8(sp)
    80006c28:	00013903          	ld	s2,0(sp)
    80006c2c:	02010113          	addi	sp,sp,32
    80006c30:	00008067          	ret

0000000080006c34 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80006c34:	fe010113          	addi	sp,sp,-32
    80006c38:	00113c23          	sd	ra,24(sp)
    80006c3c:	00813823          	sd	s0,16(sp)
    80006c40:	00913423          	sd	s1,8(sp)
    80006c44:	01213023          	sd	s2,0(sp)
    80006c48:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80006c4c:	00000913          	li	s2,0
    80006c50:	0400006f          	j	80006c90 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80006c54:	ffffb097          	auipc	ra,0xffffb
    80006c58:	a94080e7          	jalr	-1388(ra) # 800016e8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006c5c:	00148493          	addi	s1,s1,1
    80006c60:	000027b7          	lui	a5,0x2
    80006c64:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006c68:	0097ee63          	bltu	a5,s1,80006c84 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006c6c:	00000713          	li	a4,0
    80006c70:	000077b7          	lui	a5,0x7
    80006c74:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006c78:	fce7eee3          	bltu	a5,a4,80006c54 <_ZL11workerBodyBPv+0x20>
    80006c7c:	00170713          	addi	a4,a4,1
    80006c80:	ff1ff06f          	j	80006c70 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80006c84:	00a00793          	li	a5,10
    80006c88:	04f90663          	beq	s2,a5,80006cd4 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80006c8c:	00190913          	addi	s2,s2,1
    80006c90:	00f00793          	li	a5,15
    80006c94:	0527e463          	bltu	a5,s2,80006cdc <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80006c98:	00003517          	auipc	a0,0x3
    80006c9c:	51850513          	addi	a0,a0,1304 # 8000a1b0 <CONSOLE_STATUS+0x1a0>
    80006ca0:	fffff097          	auipc	ra,0xfffff
    80006ca4:	310080e7          	jalr	784(ra) # 80005fb0 <_Z11printStringPKc>
    80006ca8:	00000613          	li	a2,0
    80006cac:	00a00593          	li	a1,10
    80006cb0:	0009051b          	sext.w	a0,s2
    80006cb4:	fffff097          	auipc	ra,0xfffff
    80006cb8:	4ac080e7          	jalr	1196(ra) # 80006160 <_Z8printIntiii>
    80006cbc:	00003517          	auipc	a0,0x3
    80006cc0:	72c50513          	addi	a0,a0,1836 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006cc4:	fffff097          	auipc	ra,0xfffff
    80006cc8:	2ec080e7          	jalr	748(ra) # 80005fb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006ccc:	00000493          	li	s1,0
    80006cd0:	f91ff06f          	j	80006c60 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80006cd4:	14102ff3          	csrr	t6,sepc
    80006cd8:	fb5ff06f          	j	80006c8c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80006cdc:	00003517          	auipc	a0,0x3
    80006ce0:	4dc50513          	addi	a0,a0,1244 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    80006ce4:	fffff097          	auipc	ra,0xfffff
    80006ce8:	2cc080e7          	jalr	716(ra) # 80005fb0 <_Z11printStringPKc>
    finishedB = true;
    80006cec:	00100793          	li	a5,1
    80006cf0:	00006717          	auipc	a4,0x6
    80006cf4:	08f70223          	sb	a5,132(a4) # 8000cd74 <_ZL9finishedB>
    thread_dispatch();
    80006cf8:	ffffb097          	auipc	ra,0xffffb
    80006cfc:	9f0080e7          	jalr	-1552(ra) # 800016e8 <_Z15thread_dispatchv>
}
    80006d00:	01813083          	ld	ra,24(sp)
    80006d04:	01013403          	ld	s0,16(sp)
    80006d08:	00813483          	ld	s1,8(sp)
    80006d0c:	00013903          	ld	s2,0(sp)
    80006d10:	02010113          	addi	sp,sp,32
    80006d14:	00008067          	ret

0000000080006d18 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80006d18:	fe010113          	addi	sp,sp,-32
    80006d1c:	00113c23          	sd	ra,24(sp)
    80006d20:	00813823          	sd	s0,16(sp)
    80006d24:	00913423          	sd	s1,8(sp)
    80006d28:	01213023          	sd	s2,0(sp)
    80006d2c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80006d30:	00000913          	li	s2,0
    80006d34:	0380006f          	j	80006d6c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80006d38:	ffffb097          	auipc	ra,0xffffb
    80006d3c:	9b0080e7          	jalr	-1616(ra) # 800016e8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006d40:	00148493          	addi	s1,s1,1
    80006d44:	000027b7          	lui	a5,0x2
    80006d48:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006d4c:	0097ee63          	bltu	a5,s1,80006d68 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006d50:	00000713          	li	a4,0
    80006d54:	000077b7          	lui	a5,0x7
    80006d58:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006d5c:	fce7eee3          	bltu	a5,a4,80006d38 <_ZL11workerBodyAPv+0x20>
    80006d60:	00170713          	addi	a4,a4,1
    80006d64:	ff1ff06f          	j	80006d54 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80006d68:	00190913          	addi	s2,s2,1
    80006d6c:	00900793          	li	a5,9
    80006d70:	0527e063          	bltu	a5,s2,80006db0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80006d74:	00003517          	auipc	a0,0x3
    80006d78:	42450513          	addi	a0,a0,1060 # 8000a198 <CONSOLE_STATUS+0x188>
    80006d7c:	fffff097          	auipc	ra,0xfffff
    80006d80:	234080e7          	jalr	564(ra) # 80005fb0 <_Z11printStringPKc>
    80006d84:	00000613          	li	a2,0
    80006d88:	00a00593          	li	a1,10
    80006d8c:	0009051b          	sext.w	a0,s2
    80006d90:	fffff097          	auipc	ra,0xfffff
    80006d94:	3d0080e7          	jalr	976(ra) # 80006160 <_Z8printIntiii>
    80006d98:	00003517          	auipc	a0,0x3
    80006d9c:	65050513          	addi	a0,a0,1616 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80006da0:	fffff097          	auipc	ra,0xfffff
    80006da4:	210080e7          	jalr	528(ra) # 80005fb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006da8:	00000493          	li	s1,0
    80006dac:	f99ff06f          	j	80006d44 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80006db0:	00003517          	auipc	a0,0x3
    80006db4:	3f050513          	addi	a0,a0,1008 # 8000a1a0 <CONSOLE_STATUS+0x190>
    80006db8:	fffff097          	auipc	ra,0xfffff
    80006dbc:	1f8080e7          	jalr	504(ra) # 80005fb0 <_Z11printStringPKc>
    finishedA = true;
    80006dc0:	00100793          	li	a5,1
    80006dc4:	00006717          	auipc	a4,0x6
    80006dc8:	faf708a3          	sb	a5,-79(a4) # 8000cd75 <_ZL9finishedA>
}
    80006dcc:	01813083          	ld	ra,24(sp)
    80006dd0:	01013403          	ld	s0,16(sp)
    80006dd4:	00813483          	ld	s1,8(sp)
    80006dd8:	00013903          	ld	s2,0(sp)
    80006ddc:	02010113          	addi	sp,sp,32
    80006de0:	00008067          	ret

0000000080006de4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80006de4:	fd010113          	addi	sp,sp,-48
    80006de8:	02113423          	sd	ra,40(sp)
    80006dec:	02813023          	sd	s0,32(sp)
    80006df0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80006df4:	00000613          	li	a2,0
    80006df8:	00000597          	auipc	a1,0x0
    80006dfc:	f2058593          	addi	a1,a1,-224 # 80006d18 <_ZL11workerBodyAPv>
    80006e00:	fd040513          	addi	a0,s0,-48
    80006e04:	ffffa097          	auipc	ra,0xffffa
    80006e08:	7dc080e7          	jalr	2012(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80006e0c:	00003517          	auipc	a0,0x3
    80006e10:	42450513          	addi	a0,a0,1060 # 8000a230 <CONSOLE_STATUS+0x220>
    80006e14:	fffff097          	auipc	ra,0xfffff
    80006e18:	19c080e7          	jalr	412(ra) # 80005fb0 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006e1c:	00000613          	li	a2,0
    80006e20:	00000597          	auipc	a1,0x0
    80006e24:	e1458593          	addi	a1,a1,-492 # 80006c34 <_ZL11workerBodyBPv>
    80006e28:	fd840513          	addi	a0,s0,-40
    80006e2c:	ffffa097          	auipc	ra,0xffffa
    80006e30:	7b4080e7          	jalr	1972(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80006e34:	00003517          	auipc	a0,0x3
    80006e38:	41450513          	addi	a0,a0,1044 # 8000a248 <CONSOLE_STATUS+0x238>
    80006e3c:	fffff097          	auipc	ra,0xfffff
    80006e40:	174080e7          	jalr	372(ra) # 80005fb0 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80006e44:	00000613          	li	a2,0
    80006e48:	00000597          	auipc	a1,0x0
    80006e4c:	c6c58593          	addi	a1,a1,-916 # 80006ab4 <_ZL11workerBodyCPv>
    80006e50:	fe040513          	addi	a0,s0,-32
    80006e54:	ffffa097          	auipc	ra,0xffffa
    80006e58:	78c080e7          	jalr	1932(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80006e5c:	00003517          	auipc	a0,0x3
    80006e60:	40450513          	addi	a0,a0,1028 # 8000a260 <CONSOLE_STATUS+0x250>
    80006e64:	fffff097          	auipc	ra,0xfffff
    80006e68:	14c080e7          	jalr	332(ra) # 80005fb0 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80006e6c:	00000613          	li	a2,0
    80006e70:	00000597          	auipc	a1,0x0
    80006e74:	afc58593          	addi	a1,a1,-1284 # 8000696c <_ZL11workerBodyDPv>
    80006e78:	fe840513          	addi	a0,s0,-24
    80006e7c:	ffffa097          	auipc	ra,0xffffa
    80006e80:	764080e7          	jalr	1892(ra) # 800015e0 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    80006e84:	00003517          	auipc	a0,0x3
    80006e88:	3f450513          	addi	a0,a0,1012 # 8000a278 <CONSOLE_STATUS+0x268>
    80006e8c:	fffff097          	auipc	ra,0xfffff
    80006e90:	124080e7          	jalr	292(ra) # 80005fb0 <_Z11printStringPKc>
    80006e94:	00c0006f          	j	80006ea0 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80006e98:	ffffb097          	auipc	ra,0xffffb
    80006e9c:	850080e7          	jalr	-1968(ra) # 800016e8 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80006ea0:	00006797          	auipc	a5,0x6
    80006ea4:	ed57c783          	lbu	a5,-299(a5) # 8000cd75 <_ZL9finishedA>
    80006ea8:	fe0788e3          	beqz	a5,80006e98 <_Z16System_Mode_testv+0xb4>
    80006eac:	00006797          	auipc	a5,0x6
    80006eb0:	ec87c783          	lbu	a5,-312(a5) # 8000cd74 <_ZL9finishedB>
    80006eb4:	fe0782e3          	beqz	a5,80006e98 <_Z16System_Mode_testv+0xb4>
    80006eb8:	00006797          	auipc	a5,0x6
    80006ebc:	ebb7c783          	lbu	a5,-325(a5) # 8000cd73 <_ZL9finishedC>
    80006ec0:	fc078ce3          	beqz	a5,80006e98 <_Z16System_Mode_testv+0xb4>
    80006ec4:	00006797          	auipc	a5,0x6
    80006ec8:	eae7c783          	lbu	a5,-338(a5) # 8000cd72 <_ZL9finishedD>
    80006ecc:	fc0786e3          	beqz	a5,80006e98 <_Z16System_Mode_testv+0xb4>
    }

}
    80006ed0:	02813083          	ld	ra,40(sp)
    80006ed4:	02013403          	ld	s0,32(sp)
    80006ed8:	03010113          	addi	sp,sp,48
    80006edc:	00008067          	ret

0000000080006ee0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006ee0:	fe010113          	addi	sp,sp,-32
    80006ee4:	00113c23          	sd	ra,24(sp)
    80006ee8:	00813823          	sd	s0,16(sp)
    80006eec:	00913423          	sd	s1,8(sp)
    80006ef0:	01213023          	sd	s2,0(sp)
    80006ef4:	02010413          	addi	s0,sp,32
    80006ef8:	00050493          	mv	s1,a0
    80006efc:	00058913          	mv	s2,a1
    80006f00:	0015879b          	addiw	a5,a1,1
    80006f04:	0007851b          	sext.w	a0,a5
    80006f08:	00f4a023          	sw	a5,0(s1)
    80006f0c:	0004a823          	sw	zero,16(s1)
    80006f10:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006f14:	00251513          	slli	a0,a0,0x2
    80006f18:	ffffa097          	auipc	ra,0xffffa
    80006f1c:	644080e7          	jalr	1604(ra) # 8000155c <_Z9mem_allocm>
    80006f20:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006f24:	00000593          	li	a1,0
    80006f28:	02048513          	addi	a0,s1,32
    80006f2c:	ffffb097          	auipc	ra,0xffffb
    80006f30:	810080e7          	jalr	-2032(ra) # 8000173c <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80006f34:	00090593          	mv	a1,s2
    80006f38:	01848513          	addi	a0,s1,24
    80006f3c:	ffffb097          	auipc	ra,0xffffb
    80006f40:	800080e7          	jalr	-2048(ra) # 8000173c <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80006f44:	00100593          	li	a1,1
    80006f48:	02848513          	addi	a0,s1,40
    80006f4c:	ffffa097          	auipc	ra,0xffffa
    80006f50:	7f0080e7          	jalr	2032(ra) # 8000173c <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80006f54:	00100593          	li	a1,1
    80006f58:	03048513          	addi	a0,s1,48
    80006f5c:	ffffa097          	auipc	ra,0xffffa
    80006f60:	7e0080e7          	jalr	2016(ra) # 8000173c <_Z8sem_openPP4_semj>
}
    80006f64:	01813083          	ld	ra,24(sp)
    80006f68:	01013403          	ld	s0,16(sp)
    80006f6c:	00813483          	ld	s1,8(sp)
    80006f70:	00013903          	ld	s2,0(sp)
    80006f74:	02010113          	addi	sp,sp,32
    80006f78:	00008067          	ret

0000000080006f7c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006f7c:	fe010113          	addi	sp,sp,-32
    80006f80:	00113c23          	sd	ra,24(sp)
    80006f84:	00813823          	sd	s0,16(sp)
    80006f88:	00913423          	sd	s1,8(sp)
    80006f8c:	01213023          	sd	s2,0(sp)
    80006f90:	02010413          	addi	s0,sp,32
    80006f94:	00050493          	mv	s1,a0
    80006f98:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006f9c:	01853503          	ld	a0,24(a0)
    80006fa0:	ffffb097          	auipc	ra,0xffffb
    80006fa4:	818080e7          	jalr	-2024(ra) # 800017b8 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80006fa8:	0304b503          	ld	a0,48(s1)
    80006fac:	ffffb097          	auipc	ra,0xffffb
    80006fb0:	80c080e7          	jalr	-2036(ra) # 800017b8 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80006fb4:	0084b783          	ld	a5,8(s1)
    80006fb8:	0144a703          	lw	a4,20(s1)
    80006fbc:	00271713          	slli	a4,a4,0x2
    80006fc0:	00e787b3          	add	a5,a5,a4
    80006fc4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006fc8:	0144a783          	lw	a5,20(s1)
    80006fcc:	0017879b          	addiw	a5,a5,1
    80006fd0:	0004a703          	lw	a4,0(s1)
    80006fd4:	02e7e7bb          	remw	a5,a5,a4
    80006fd8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006fdc:	0304b503          	ld	a0,48(s1)
    80006fe0:	ffffb097          	auipc	ra,0xffffb
    80006fe4:	810080e7          	jalr	-2032(ra) # 800017f0 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80006fe8:	0204b503          	ld	a0,32(s1)
    80006fec:	ffffb097          	auipc	ra,0xffffb
    80006ff0:	804080e7          	jalr	-2044(ra) # 800017f0 <_Z10sem_signalP4_sem>

}
    80006ff4:	01813083          	ld	ra,24(sp)
    80006ff8:	01013403          	ld	s0,16(sp)
    80006ffc:	00813483          	ld	s1,8(sp)
    80007000:	00013903          	ld	s2,0(sp)
    80007004:	02010113          	addi	sp,sp,32
    80007008:	00008067          	ret

000000008000700c <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000700c:	fe010113          	addi	sp,sp,-32
    80007010:	00113c23          	sd	ra,24(sp)
    80007014:	00813823          	sd	s0,16(sp)
    80007018:	00913423          	sd	s1,8(sp)
    8000701c:	01213023          	sd	s2,0(sp)
    80007020:	02010413          	addi	s0,sp,32
    80007024:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80007028:	02053503          	ld	a0,32(a0)
    8000702c:	ffffa097          	auipc	ra,0xffffa
    80007030:	78c080e7          	jalr	1932(ra) # 800017b8 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80007034:	0284b503          	ld	a0,40(s1)
    80007038:	ffffa097          	auipc	ra,0xffffa
    8000703c:	780080e7          	jalr	1920(ra) # 800017b8 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80007040:	0084b703          	ld	a4,8(s1)
    80007044:	0104a783          	lw	a5,16(s1)
    80007048:	00279693          	slli	a3,a5,0x2
    8000704c:	00d70733          	add	a4,a4,a3
    80007050:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80007054:	0017879b          	addiw	a5,a5,1
    80007058:	0004a703          	lw	a4,0(s1)
    8000705c:	02e7e7bb          	remw	a5,a5,a4
    80007060:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80007064:	0284b503          	ld	a0,40(s1)
    80007068:	ffffa097          	auipc	ra,0xffffa
    8000706c:	788080e7          	jalr	1928(ra) # 800017f0 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80007070:	0184b503          	ld	a0,24(s1)
    80007074:	ffffa097          	auipc	ra,0xffffa
    80007078:	77c080e7          	jalr	1916(ra) # 800017f0 <_Z10sem_signalP4_sem>

    return ret;
}
    8000707c:	00090513          	mv	a0,s2
    80007080:	01813083          	ld	ra,24(sp)
    80007084:	01013403          	ld	s0,16(sp)
    80007088:	00813483          	ld	s1,8(sp)
    8000708c:	00013903          	ld	s2,0(sp)
    80007090:	02010113          	addi	sp,sp,32
    80007094:	00008067          	ret

0000000080007098 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80007098:	fe010113          	addi	sp,sp,-32
    8000709c:	00113c23          	sd	ra,24(sp)
    800070a0:	00813823          	sd	s0,16(sp)
    800070a4:	00913423          	sd	s1,8(sp)
    800070a8:	01213023          	sd	s2,0(sp)
    800070ac:	02010413          	addi	s0,sp,32
    800070b0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800070b4:	02853503          	ld	a0,40(a0)
    800070b8:	ffffa097          	auipc	ra,0xffffa
    800070bc:	700080e7          	jalr	1792(ra) # 800017b8 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    800070c0:	0304b503          	ld	a0,48(s1)
    800070c4:	ffffa097          	auipc	ra,0xffffa
    800070c8:	6f4080e7          	jalr	1780(ra) # 800017b8 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    800070cc:	0144a783          	lw	a5,20(s1)
    800070d0:	0104a903          	lw	s2,16(s1)
    800070d4:	0327ce63          	blt	a5,s2,80007110 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800070d8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800070dc:	0304b503          	ld	a0,48(s1)
    800070e0:	ffffa097          	auipc	ra,0xffffa
    800070e4:	710080e7          	jalr	1808(ra) # 800017f0 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    800070e8:	0284b503          	ld	a0,40(s1)
    800070ec:	ffffa097          	auipc	ra,0xffffa
    800070f0:	704080e7          	jalr	1796(ra) # 800017f0 <_Z10sem_signalP4_sem>

    return ret;
}
    800070f4:	00090513          	mv	a0,s2
    800070f8:	01813083          	ld	ra,24(sp)
    800070fc:	01013403          	ld	s0,16(sp)
    80007100:	00813483          	ld	s1,8(sp)
    80007104:	00013903          	ld	s2,0(sp)
    80007108:	02010113          	addi	sp,sp,32
    8000710c:	00008067          	ret
        ret = cap - head + tail;
    80007110:	0004a703          	lw	a4,0(s1)
    80007114:	4127093b          	subw	s2,a4,s2
    80007118:	00f9093b          	addw	s2,s2,a5
    8000711c:	fc1ff06f          	j	800070dc <_ZN6Buffer6getCntEv+0x44>

0000000080007120 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80007120:	fe010113          	addi	sp,sp,-32
    80007124:	00113c23          	sd	ra,24(sp)
    80007128:	00813823          	sd	s0,16(sp)
    8000712c:	00913423          	sd	s1,8(sp)
    80007130:	02010413          	addi	s0,sp,32
    80007134:	00050493          	mv	s1,a0
    putc('\n');
    80007138:	00a00513          	li	a0,10
    8000713c:	ffffa097          	auipc	ra,0xffffa
    80007140:	758080e7          	jalr	1880(ra) # 80001894 <_Z4putcc>
    printString("Buffer deleted!\n");
    80007144:	00003517          	auipc	a0,0x3
    80007148:	14c50513          	addi	a0,a0,332 # 8000a290 <CONSOLE_STATUS+0x280>
    8000714c:	fffff097          	auipc	ra,0xfffff
    80007150:	e64080e7          	jalr	-412(ra) # 80005fb0 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80007154:	00048513          	mv	a0,s1
    80007158:	00000097          	auipc	ra,0x0
    8000715c:	f40080e7          	jalr	-192(ra) # 80007098 <_ZN6Buffer6getCntEv>
    80007160:	02a05c63          	blez	a0,80007198 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80007164:	0084b783          	ld	a5,8(s1)
    80007168:	0104a703          	lw	a4,16(s1)
    8000716c:	00271713          	slli	a4,a4,0x2
    80007170:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80007174:	0007c503          	lbu	a0,0(a5)
    80007178:	ffffa097          	auipc	ra,0xffffa
    8000717c:	71c080e7          	jalr	1820(ra) # 80001894 <_Z4putcc>
        head = (head + 1) % cap;
    80007180:	0104a783          	lw	a5,16(s1)
    80007184:	0017879b          	addiw	a5,a5,1
    80007188:	0004a703          	lw	a4,0(s1)
    8000718c:	02e7e7bb          	remw	a5,a5,a4
    80007190:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007194:	fc1ff06f          	j	80007154 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80007198:	02100513          	li	a0,33
    8000719c:	ffffa097          	auipc	ra,0xffffa
    800071a0:	6f8080e7          	jalr	1784(ra) # 80001894 <_Z4putcc>
    putc('\n');
    800071a4:	00a00513          	li	a0,10
    800071a8:	ffffa097          	auipc	ra,0xffffa
    800071ac:	6ec080e7          	jalr	1772(ra) # 80001894 <_Z4putcc>
    mem_free(buffer);
    800071b0:	0084b503          	ld	a0,8(s1)
    800071b4:	ffffa097          	auipc	ra,0xffffa
    800071b8:	3f4080e7          	jalr	1012(ra) # 800015a8 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800071bc:	0204b503          	ld	a0,32(s1)
    800071c0:	ffffa097          	auipc	ra,0xffffa
    800071c4:	5c0080e7          	jalr	1472(ra) # 80001780 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    800071c8:	0184b503          	ld	a0,24(s1)
    800071cc:	ffffa097          	auipc	ra,0xffffa
    800071d0:	5b4080e7          	jalr	1460(ra) # 80001780 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    800071d4:	0304b503          	ld	a0,48(s1)
    800071d8:	ffffa097          	auipc	ra,0xffffa
    800071dc:	5a8080e7          	jalr	1448(ra) # 80001780 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    800071e0:	0284b503          	ld	a0,40(s1)
    800071e4:	ffffa097          	auipc	ra,0xffffa
    800071e8:	59c080e7          	jalr	1436(ra) # 80001780 <_Z9sem_closeP4_sem>
}
    800071ec:	01813083          	ld	ra,24(sp)
    800071f0:	01013403          	ld	s0,16(sp)
    800071f4:	00813483          	ld	s1,8(sp)
    800071f8:	02010113          	addi	sp,sp,32
    800071fc:	00008067          	ret

0000000080007200 <start>:
    80007200:	ff010113          	addi	sp,sp,-16
    80007204:	00813423          	sd	s0,8(sp)
    80007208:	01010413          	addi	s0,sp,16
    8000720c:	300027f3          	csrr	a5,mstatus
    80007210:	ffffe737          	lui	a4,0xffffe
    80007214:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff081f>
    80007218:	00e7f7b3          	and	a5,a5,a4
    8000721c:	00001737          	lui	a4,0x1
    80007220:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007224:	00e7e7b3          	or	a5,a5,a4
    80007228:	30079073          	csrw	mstatus,a5
    8000722c:	00000797          	auipc	a5,0x0
    80007230:	16078793          	addi	a5,a5,352 # 8000738c <system_main>
    80007234:	34179073          	csrw	mepc,a5
    80007238:	00000793          	li	a5,0
    8000723c:	18079073          	csrw	satp,a5
    80007240:	000107b7          	lui	a5,0x10
    80007244:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80007248:	30279073          	csrw	medeleg,a5
    8000724c:	30379073          	csrw	mideleg,a5
    80007250:	104027f3          	csrr	a5,sie
    80007254:	2227e793          	ori	a5,a5,546
    80007258:	10479073          	csrw	sie,a5
    8000725c:	fff00793          	li	a5,-1
    80007260:	00a7d793          	srli	a5,a5,0xa
    80007264:	3b079073          	csrw	pmpaddr0,a5
    80007268:	00f00793          	li	a5,15
    8000726c:	3a079073          	csrw	pmpcfg0,a5
    80007270:	f14027f3          	csrr	a5,mhartid
    80007274:	0200c737          	lui	a4,0x200c
    80007278:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000727c:	0007869b          	sext.w	a3,a5
    80007280:	00269713          	slli	a4,a3,0x2
    80007284:	000f4637          	lui	a2,0xf4
    80007288:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000728c:	00d70733          	add	a4,a4,a3
    80007290:	0037979b          	slliw	a5,a5,0x3
    80007294:	020046b7          	lui	a3,0x2004
    80007298:	00d787b3          	add	a5,a5,a3
    8000729c:	00c585b3          	add	a1,a1,a2
    800072a0:	00371693          	slli	a3,a4,0x3
    800072a4:	00006717          	auipc	a4,0x6
    800072a8:	adc70713          	addi	a4,a4,-1316 # 8000cd80 <timer_scratch>
    800072ac:	00b7b023          	sd	a1,0(a5)
    800072b0:	00d70733          	add	a4,a4,a3
    800072b4:	00f73c23          	sd	a5,24(a4)
    800072b8:	02c73023          	sd	a2,32(a4)
    800072bc:	34071073          	csrw	mscratch,a4
    800072c0:	00000797          	auipc	a5,0x0
    800072c4:	6e078793          	addi	a5,a5,1760 # 800079a0 <timervec>
    800072c8:	30579073          	csrw	mtvec,a5
    800072cc:	300027f3          	csrr	a5,mstatus
    800072d0:	0087e793          	ori	a5,a5,8
    800072d4:	30079073          	csrw	mstatus,a5
    800072d8:	304027f3          	csrr	a5,mie
    800072dc:	0807e793          	ori	a5,a5,128
    800072e0:	30479073          	csrw	mie,a5
    800072e4:	f14027f3          	csrr	a5,mhartid
    800072e8:	0007879b          	sext.w	a5,a5
    800072ec:	00078213          	mv	tp,a5
    800072f0:	30200073          	mret
    800072f4:	00813403          	ld	s0,8(sp)
    800072f8:	01010113          	addi	sp,sp,16
    800072fc:	00008067          	ret

0000000080007300 <timerinit>:
    80007300:	ff010113          	addi	sp,sp,-16
    80007304:	00813423          	sd	s0,8(sp)
    80007308:	01010413          	addi	s0,sp,16
    8000730c:	f14027f3          	csrr	a5,mhartid
    80007310:	0200c737          	lui	a4,0x200c
    80007314:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007318:	0007869b          	sext.w	a3,a5
    8000731c:	00269713          	slli	a4,a3,0x2
    80007320:	000f4637          	lui	a2,0xf4
    80007324:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007328:	00d70733          	add	a4,a4,a3
    8000732c:	0037979b          	slliw	a5,a5,0x3
    80007330:	020046b7          	lui	a3,0x2004
    80007334:	00d787b3          	add	a5,a5,a3
    80007338:	00c585b3          	add	a1,a1,a2
    8000733c:	00371693          	slli	a3,a4,0x3
    80007340:	00006717          	auipc	a4,0x6
    80007344:	a4070713          	addi	a4,a4,-1472 # 8000cd80 <timer_scratch>
    80007348:	00b7b023          	sd	a1,0(a5)
    8000734c:	00d70733          	add	a4,a4,a3
    80007350:	00f73c23          	sd	a5,24(a4)
    80007354:	02c73023          	sd	a2,32(a4)
    80007358:	34071073          	csrw	mscratch,a4
    8000735c:	00000797          	auipc	a5,0x0
    80007360:	64478793          	addi	a5,a5,1604 # 800079a0 <timervec>
    80007364:	30579073          	csrw	mtvec,a5
    80007368:	300027f3          	csrr	a5,mstatus
    8000736c:	0087e793          	ori	a5,a5,8
    80007370:	30079073          	csrw	mstatus,a5
    80007374:	304027f3          	csrr	a5,mie
    80007378:	0807e793          	ori	a5,a5,128
    8000737c:	30479073          	csrw	mie,a5
    80007380:	00813403          	ld	s0,8(sp)
    80007384:	01010113          	addi	sp,sp,16
    80007388:	00008067          	ret

000000008000738c <system_main>:
    8000738c:	fe010113          	addi	sp,sp,-32
    80007390:	00813823          	sd	s0,16(sp)
    80007394:	00913423          	sd	s1,8(sp)
    80007398:	00113c23          	sd	ra,24(sp)
    8000739c:	02010413          	addi	s0,sp,32
    800073a0:	00000097          	auipc	ra,0x0
    800073a4:	0c4080e7          	jalr	196(ra) # 80007464 <cpuid>
    800073a8:	00006497          	auipc	s1,0x6
    800073ac:	8d848493          	addi	s1,s1,-1832 # 8000cc80 <started>
    800073b0:	02050263          	beqz	a0,800073d4 <system_main+0x48>
    800073b4:	0004a783          	lw	a5,0(s1)
    800073b8:	0007879b          	sext.w	a5,a5
    800073bc:	fe078ce3          	beqz	a5,800073b4 <system_main+0x28>
    800073c0:	0ff0000f          	fence
    800073c4:	00003517          	auipc	a0,0x3
    800073c8:	19c50513          	addi	a0,a0,412 # 8000a560 <CONSOLE_STATUS+0x550>
    800073cc:	00001097          	auipc	ra,0x1
    800073d0:	a70080e7          	jalr	-1424(ra) # 80007e3c <panic>
    800073d4:	00001097          	auipc	ra,0x1
    800073d8:	9c4080e7          	jalr	-1596(ra) # 80007d98 <consoleinit>
    800073dc:	00001097          	auipc	ra,0x1
    800073e0:	150080e7          	jalr	336(ra) # 8000852c <printfinit>
    800073e4:	00003517          	auipc	a0,0x3
    800073e8:	00450513          	addi	a0,a0,4 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    800073ec:	00001097          	auipc	ra,0x1
    800073f0:	aac080e7          	jalr	-1364(ra) # 80007e98 <__printf>
    800073f4:	00003517          	auipc	a0,0x3
    800073f8:	13c50513          	addi	a0,a0,316 # 8000a530 <CONSOLE_STATUS+0x520>
    800073fc:	00001097          	auipc	ra,0x1
    80007400:	a9c080e7          	jalr	-1380(ra) # 80007e98 <__printf>
    80007404:	00003517          	auipc	a0,0x3
    80007408:	fe450513          	addi	a0,a0,-28 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    8000740c:	00001097          	auipc	ra,0x1
    80007410:	a8c080e7          	jalr	-1396(ra) # 80007e98 <__printf>
    80007414:	00001097          	auipc	ra,0x1
    80007418:	4a4080e7          	jalr	1188(ra) # 800088b8 <kinit>
    8000741c:	00000097          	auipc	ra,0x0
    80007420:	148080e7          	jalr	328(ra) # 80007564 <trapinit>
    80007424:	00000097          	auipc	ra,0x0
    80007428:	16c080e7          	jalr	364(ra) # 80007590 <trapinithart>
    8000742c:	00000097          	auipc	ra,0x0
    80007430:	5b4080e7          	jalr	1460(ra) # 800079e0 <plicinit>
    80007434:	00000097          	auipc	ra,0x0
    80007438:	5d4080e7          	jalr	1492(ra) # 80007a08 <plicinithart>
    8000743c:	00000097          	auipc	ra,0x0
    80007440:	078080e7          	jalr	120(ra) # 800074b4 <userinit>
    80007444:	0ff0000f          	fence
    80007448:	00100793          	li	a5,1
    8000744c:	00003517          	auipc	a0,0x3
    80007450:	0fc50513          	addi	a0,a0,252 # 8000a548 <CONSOLE_STATUS+0x538>
    80007454:	00f4a023          	sw	a5,0(s1)
    80007458:	00001097          	auipc	ra,0x1
    8000745c:	a40080e7          	jalr	-1472(ra) # 80007e98 <__printf>
    80007460:	0000006f          	j	80007460 <system_main+0xd4>

0000000080007464 <cpuid>:
    80007464:	ff010113          	addi	sp,sp,-16
    80007468:	00813423          	sd	s0,8(sp)
    8000746c:	01010413          	addi	s0,sp,16
    80007470:	00020513          	mv	a0,tp
    80007474:	00813403          	ld	s0,8(sp)
    80007478:	0005051b          	sext.w	a0,a0
    8000747c:	01010113          	addi	sp,sp,16
    80007480:	00008067          	ret

0000000080007484 <mycpu>:
    80007484:	ff010113          	addi	sp,sp,-16
    80007488:	00813423          	sd	s0,8(sp)
    8000748c:	01010413          	addi	s0,sp,16
    80007490:	00020793          	mv	a5,tp
    80007494:	00813403          	ld	s0,8(sp)
    80007498:	0007879b          	sext.w	a5,a5
    8000749c:	00779793          	slli	a5,a5,0x7
    800074a0:	00007517          	auipc	a0,0x7
    800074a4:	91050513          	addi	a0,a0,-1776 # 8000ddb0 <cpus>
    800074a8:	00f50533          	add	a0,a0,a5
    800074ac:	01010113          	addi	sp,sp,16
    800074b0:	00008067          	ret

00000000800074b4 <userinit>:
    800074b4:	ff010113          	addi	sp,sp,-16
    800074b8:	00813423          	sd	s0,8(sp)
    800074bc:	01010413          	addi	s0,sp,16
    800074c0:	00813403          	ld	s0,8(sp)
    800074c4:	01010113          	addi	sp,sp,16
    800074c8:	ffffa317          	auipc	t1,0xffffa
    800074cc:	5fc30067          	jr	1532(t1) # 80001ac4 <main>

00000000800074d0 <either_copyout>:
    800074d0:	ff010113          	addi	sp,sp,-16
    800074d4:	00813023          	sd	s0,0(sp)
    800074d8:	00113423          	sd	ra,8(sp)
    800074dc:	01010413          	addi	s0,sp,16
    800074e0:	02051663          	bnez	a0,8000750c <either_copyout+0x3c>
    800074e4:	00058513          	mv	a0,a1
    800074e8:	00060593          	mv	a1,a2
    800074ec:	0006861b          	sext.w	a2,a3
    800074f0:	00002097          	auipc	ra,0x2
    800074f4:	c54080e7          	jalr	-940(ra) # 80009144 <__memmove>
    800074f8:	00813083          	ld	ra,8(sp)
    800074fc:	00013403          	ld	s0,0(sp)
    80007500:	00000513          	li	a0,0
    80007504:	01010113          	addi	sp,sp,16
    80007508:	00008067          	ret
    8000750c:	00003517          	auipc	a0,0x3
    80007510:	07c50513          	addi	a0,a0,124 # 8000a588 <CONSOLE_STATUS+0x578>
    80007514:	00001097          	auipc	ra,0x1
    80007518:	928080e7          	jalr	-1752(ra) # 80007e3c <panic>

000000008000751c <either_copyin>:
    8000751c:	ff010113          	addi	sp,sp,-16
    80007520:	00813023          	sd	s0,0(sp)
    80007524:	00113423          	sd	ra,8(sp)
    80007528:	01010413          	addi	s0,sp,16
    8000752c:	02059463          	bnez	a1,80007554 <either_copyin+0x38>
    80007530:	00060593          	mv	a1,a2
    80007534:	0006861b          	sext.w	a2,a3
    80007538:	00002097          	auipc	ra,0x2
    8000753c:	c0c080e7          	jalr	-1012(ra) # 80009144 <__memmove>
    80007540:	00813083          	ld	ra,8(sp)
    80007544:	00013403          	ld	s0,0(sp)
    80007548:	00000513          	li	a0,0
    8000754c:	01010113          	addi	sp,sp,16
    80007550:	00008067          	ret
    80007554:	00003517          	auipc	a0,0x3
    80007558:	05c50513          	addi	a0,a0,92 # 8000a5b0 <CONSOLE_STATUS+0x5a0>
    8000755c:	00001097          	auipc	ra,0x1
    80007560:	8e0080e7          	jalr	-1824(ra) # 80007e3c <panic>

0000000080007564 <trapinit>:
    80007564:	ff010113          	addi	sp,sp,-16
    80007568:	00813423          	sd	s0,8(sp)
    8000756c:	01010413          	addi	s0,sp,16
    80007570:	00813403          	ld	s0,8(sp)
    80007574:	00003597          	auipc	a1,0x3
    80007578:	06458593          	addi	a1,a1,100 # 8000a5d8 <CONSOLE_STATUS+0x5c8>
    8000757c:	00007517          	auipc	a0,0x7
    80007580:	8b450513          	addi	a0,a0,-1868 # 8000de30 <tickslock>
    80007584:	01010113          	addi	sp,sp,16
    80007588:	00001317          	auipc	t1,0x1
    8000758c:	5c030067          	jr	1472(t1) # 80008b48 <initlock>

0000000080007590 <trapinithart>:
    80007590:	ff010113          	addi	sp,sp,-16
    80007594:	00813423          	sd	s0,8(sp)
    80007598:	01010413          	addi	s0,sp,16
    8000759c:	00000797          	auipc	a5,0x0
    800075a0:	2f478793          	addi	a5,a5,756 # 80007890 <kernelvec>
    800075a4:	10579073          	csrw	stvec,a5
    800075a8:	00813403          	ld	s0,8(sp)
    800075ac:	01010113          	addi	sp,sp,16
    800075b0:	00008067          	ret

00000000800075b4 <usertrap>:
    800075b4:	ff010113          	addi	sp,sp,-16
    800075b8:	00813423          	sd	s0,8(sp)
    800075bc:	01010413          	addi	s0,sp,16
    800075c0:	00813403          	ld	s0,8(sp)
    800075c4:	01010113          	addi	sp,sp,16
    800075c8:	00008067          	ret

00000000800075cc <usertrapret>:
    800075cc:	ff010113          	addi	sp,sp,-16
    800075d0:	00813423          	sd	s0,8(sp)
    800075d4:	01010413          	addi	s0,sp,16
    800075d8:	00813403          	ld	s0,8(sp)
    800075dc:	01010113          	addi	sp,sp,16
    800075e0:	00008067          	ret

00000000800075e4 <kerneltrap>:
    800075e4:	fe010113          	addi	sp,sp,-32
    800075e8:	00813823          	sd	s0,16(sp)
    800075ec:	00113c23          	sd	ra,24(sp)
    800075f0:	00913423          	sd	s1,8(sp)
    800075f4:	02010413          	addi	s0,sp,32
    800075f8:	142025f3          	csrr	a1,scause
    800075fc:	100027f3          	csrr	a5,sstatus
    80007600:	0027f793          	andi	a5,a5,2
    80007604:	10079c63          	bnez	a5,8000771c <kerneltrap+0x138>
    80007608:	142027f3          	csrr	a5,scause
    8000760c:	0207ce63          	bltz	a5,80007648 <kerneltrap+0x64>
    80007610:	00003517          	auipc	a0,0x3
    80007614:	01050513          	addi	a0,a0,16 # 8000a620 <CONSOLE_STATUS+0x610>
    80007618:	00001097          	auipc	ra,0x1
    8000761c:	880080e7          	jalr	-1920(ra) # 80007e98 <__printf>
    80007620:	141025f3          	csrr	a1,sepc
    80007624:	14302673          	csrr	a2,stval
    80007628:	00003517          	auipc	a0,0x3
    8000762c:	00850513          	addi	a0,a0,8 # 8000a630 <CONSOLE_STATUS+0x620>
    80007630:	00001097          	auipc	ra,0x1
    80007634:	868080e7          	jalr	-1944(ra) # 80007e98 <__printf>
    80007638:	00003517          	auipc	a0,0x3
    8000763c:	01050513          	addi	a0,a0,16 # 8000a648 <CONSOLE_STATUS+0x638>
    80007640:	00000097          	auipc	ra,0x0
    80007644:	7fc080e7          	jalr	2044(ra) # 80007e3c <panic>
    80007648:	0ff7f713          	andi	a4,a5,255
    8000764c:	00900693          	li	a3,9
    80007650:	04d70063          	beq	a4,a3,80007690 <kerneltrap+0xac>
    80007654:	fff00713          	li	a4,-1
    80007658:	03f71713          	slli	a4,a4,0x3f
    8000765c:	00170713          	addi	a4,a4,1
    80007660:	fae798e3          	bne	a5,a4,80007610 <kerneltrap+0x2c>
    80007664:	00000097          	auipc	ra,0x0
    80007668:	e00080e7          	jalr	-512(ra) # 80007464 <cpuid>
    8000766c:	06050663          	beqz	a0,800076d8 <kerneltrap+0xf4>
    80007670:	144027f3          	csrr	a5,sip
    80007674:	ffd7f793          	andi	a5,a5,-3
    80007678:	14479073          	csrw	sip,a5
    8000767c:	01813083          	ld	ra,24(sp)
    80007680:	01013403          	ld	s0,16(sp)
    80007684:	00813483          	ld	s1,8(sp)
    80007688:	02010113          	addi	sp,sp,32
    8000768c:	00008067          	ret
    80007690:	00000097          	auipc	ra,0x0
    80007694:	3c4080e7          	jalr	964(ra) # 80007a54 <plic_claim>
    80007698:	00a00793          	li	a5,10
    8000769c:	00050493          	mv	s1,a0
    800076a0:	06f50863          	beq	a0,a5,80007710 <kerneltrap+0x12c>
    800076a4:	fc050ce3          	beqz	a0,8000767c <kerneltrap+0x98>
    800076a8:	00050593          	mv	a1,a0
    800076ac:	00003517          	auipc	a0,0x3
    800076b0:	f5450513          	addi	a0,a0,-172 # 8000a600 <CONSOLE_STATUS+0x5f0>
    800076b4:	00000097          	auipc	ra,0x0
    800076b8:	7e4080e7          	jalr	2020(ra) # 80007e98 <__printf>
    800076bc:	01013403          	ld	s0,16(sp)
    800076c0:	01813083          	ld	ra,24(sp)
    800076c4:	00048513          	mv	a0,s1
    800076c8:	00813483          	ld	s1,8(sp)
    800076cc:	02010113          	addi	sp,sp,32
    800076d0:	00000317          	auipc	t1,0x0
    800076d4:	3bc30067          	jr	956(t1) # 80007a8c <plic_complete>
    800076d8:	00006517          	auipc	a0,0x6
    800076dc:	75850513          	addi	a0,a0,1880 # 8000de30 <tickslock>
    800076e0:	00001097          	auipc	ra,0x1
    800076e4:	48c080e7          	jalr	1164(ra) # 80008b6c <acquire>
    800076e8:	00005717          	auipc	a4,0x5
    800076ec:	59c70713          	addi	a4,a4,1436 # 8000cc84 <ticks>
    800076f0:	00072783          	lw	a5,0(a4)
    800076f4:	00006517          	auipc	a0,0x6
    800076f8:	73c50513          	addi	a0,a0,1852 # 8000de30 <tickslock>
    800076fc:	0017879b          	addiw	a5,a5,1
    80007700:	00f72023          	sw	a5,0(a4)
    80007704:	00001097          	auipc	ra,0x1
    80007708:	534080e7          	jalr	1332(ra) # 80008c38 <release>
    8000770c:	f65ff06f          	j	80007670 <kerneltrap+0x8c>
    80007710:	00001097          	auipc	ra,0x1
    80007714:	090080e7          	jalr	144(ra) # 800087a0 <uartintr>
    80007718:	fa5ff06f          	j	800076bc <kerneltrap+0xd8>
    8000771c:	00003517          	auipc	a0,0x3
    80007720:	ec450513          	addi	a0,a0,-316 # 8000a5e0 <CONSOLE_STATUS+0x5d0>
    80007724:	00000097          	auipc	ra,0x0
    80007728:	718080e7          	jalr	1816(ra) # 80007e3c <panic>

000000008000772c <clockintr>:
    8000772c:	fe010113          	addi	sp,sp,-32
    80007730:	00813823          	sd	s0,16(sp)
    80007734:	00913423          	sd	s1,8(sp)
    80007738:	00113c23          	sd	ra,24(sp)
    8000773c:	02010413          	addi	s0,sp,32
    80007740:	00006497          	auipc	s1,0x6
    80007744:	6f048493          	addi	s1,s1,1776 # 8000de30 <tickslock>
    80007748:	00048513          	mv	a0,s1
    8000774c:	00001097          	auipc	ra,0x1
    80007750:	420080e7          	jalr	1056(ra) # 80008b6c <acquire>
    80007754:	00005717          	auipc	a4,0x5
    80007758:	53070713          	addi	a4,a4,1328 # 8000cc84 <ticks>
    8000775c:	00072783          	lw	a5,0(a4)
    80007760:	01013403          	ld	s0,16(sp)
    80007764:	01813083          	ld	ra,24(sp)
    80007768:	00048513          	mv	a0,s1
    8000776c:	0017879b          	addiw	a5,a5,1
    80007770:	00813483          	ld	s1,8(sp)
    80007774:	00f72023          	sw	a5,0(a4)
    80007778:	02010113          	addi	sp,sp,32
    8000777c:	00001317          	auipc	t1,0x1
    80007780:	4bc30067          	jr	1212(t1) # 80008c38 <release>

0000000080007784 <devintr>:
    80007784:	142027f3          	csrr	a5,scause
    80007788:	00000513          	li	a0,0
    8000778c:	0007c463          	bltz	a5,80007794 <devintr+0x10>
    80007790:	00008067          	ret
    80007794:	fe010113          	addi	sp,sp,-32
    80007798:	00813823          	sd	s0,16(sp)
    8000779c:	00113c23          	sd	ra,24(sp)
    800077a0:	00913423          	sd	s1,8(sp)
    800077a4:	02010413          	addi	s0,sp,32
    800077a8:	0ff7f713          	andi	a4,a5,255
    800077ac:	00900693          	li	a3,9
    800077b0:	04d70c63          	beq	a4,a3,80007808 <devintr+0x84>
    800077b4:	fff00713          	li	a4,-1
    800077b8:	03f71713          	slli	a4,a4,0x3f
    800077bc:	00170713          	addi	a4,a4,1
    800077c0:	00e78c63          	beq	a5,a4,800077d8 <devintr+0x54>
    800077c4:	01813083          	ld	ra,24(sp)
    800077c8:	01013403          	ld	s0,16(sp)
    800077cc:	00813483          	ld	s1,8(sp)
    800077d0:	02010113          	addi	sp,sp,32
    800077d4:	00008067          	ret
    800077d8:	00000097          	auipc	ra,0x0
    800077dc:	c8c080e7          	jalr	-884(ra) # 80007464 <cpuid>
    800077e0:	06050663          	beqz	a0,8000784c <devintr+0xc8>
    800077e4:	144027f3          	csrr	a5,sip
    800077e8:	ffd7f793          	andi	a5,a5,-3
    800077ec:	14479073          	csrw	sip,a5
    800077f0:	01813083          	ld	ra,24(sp)
    800077f4:	01013403          	ld	s0,16(sp)
    800077f8:	00813483          	ld	s1,8(sp)
    800077fc:	00200513          	li	a0,2
    80007800:	02010113          	addi	sp,sp,32
    80007804:	00008067          	ret
    80007808:	00000097          	auipc	ra,0x0
    8000780c:	24c080e7          	jalr	588(ra) # 80007a54 <plic_claim>
    80007810:	00a00793          	li	a5,10
    80007814:	00050493          	mv	s1,a0
    80007818:	06f50663          	beq	a0,a5,80007884 <devintr+0x100>
    8000781c:	00100513          	li	a0,1
    80007820:	fa0482e3          	beqz	s1,800077c4 <devintr+0x40>
    80007824:	00048593          	mv	a1,s1
    80007828:	00003517          	auipc	a0,0x3
    8000782c:	dd850513          	addi	a0,a0,-552 # 8000a600 <CONSOLE_STATUS+0x5f0>
    80007830:	00000097          	auipc	ra,0x0
    80007834:	668080e7          	jalr	1640(ra) # 80007e98 <__printf>
    80007838:	00048513          	mv	a0,s1
    8000783c:	00000097          	auipc	ra,0x0
    80007840:	250080e7          	jalr	592(ra) # 80007a8c <plic_complete>
    80007844:	00100513          	li	a0,1
    80007848:	f7dff06f          	j	800077c4 <devintr+0x40>
    8000784c:	00006517          	auipc	a0,0x6
    80007850:	5e450513          	addi	a0,a0,1508 # 8000de30 <tickslock>
    80007854:	00001097          	auipc	ra,0x1
    80007858:	318080e7          	jalr	792(ra) # 80008b6c <acquire>
    8000785c:	00005717          	auipc	a4,0x5
    80007860:	42870713          	addi	a4,a4,1064 # 8000cc84 <ticks>
    80007864:	00072783          	lw	a5,0(a4)
    80007868:	00006517          	auipc	a0,0x6
    8000786c:	5c850513          	addi	a0,a0,1480 # 8000de30 <tickslock>
    80007870:	0017879b          	addiw	a5,a5,1
    80007874:	00f72023          	sw	a5,0(a4)
    80007878:	00001097          	auipc	ra,0x1
    8000787c:	3c0080e7          	jalr	960(ra) # 80008c38 <release>
    80007880:	f65ff06f          	j	800077e4 <devintr+0x60>
    80007884:	00001097          	auipc	ra,0x1
    80007888:	f1c080e7          	jalr	-228(ra) # 800087a0 <uartintr>
    8000788c:	fadff06f          	j	80007838 <devintr+0xb4>

0000000080007890 <kernelvec>:
    80007890:	f0010113          	addi	sp,sp,-256
    80007894:	00113023          	sd	ra,0(sp)
    80007898:	00213423          	sd	sp,8(sp)
    8000789c:	00313823          	sd	gp,16(sp)
    800078a0:	00413c23          	sd	tp,24(sp)
    800078a4:	02513023          	sd	t0,32(sp)
    800078a8:	02613423          	sd	t1,40(sp)
    800078ac:	02713823          	sd	t2,48(sp)
    800078b0:	02813c23          	sd	s0,56(sp)
    800078b4:	04913023          	sd	s1,64(sp)
    800078b8:	04a13423          	sd	a0,72(sp)
    800078bc:	04b13823          	sd	a1,80(sp)
    800078c0:	04c13c23          	sd	a2,88(sp)
    800078c4:	06d13023          	sd	a3,96(sp)
    800078c8:	06e13423          	sd	a4,104(sp)
    800078cc:	06f13823          	sd	a5,112(sp)
    800078d0:	07013c23          	sd	a6,120(sp)
    800078d4:	09113023          	sd	a7,128(sp)
    800078d8:	09213423          	sd	s2,136(sp)
    800078dc:	09313823          	sd	s3,144(sp)
    800078e0:	09413c23          	sd	s4,152(sp)
    800078e4:	0b513023          	sd	s5,160(sp)
    800078e8:	0b613423          	sd	s6,168(sp)
    800078ec:	0b713823          	sd	s7,176(sp)
    800078f0:	0b813c23          	sd	s8,184(sp)
    800078f4:	0d913023          	sd	s9,192(sp)
    800078f8:	0da13423          	sd	s10,200(sp)
    800078fc:	0db13823          	sd	s11,208(sp)
    80007900:	0dc13c23          	sd	t3,216(sp)
    80007904:	0fd13023          	sd	t4,224(sp)
    80007908:	0fe13423          	sd	t5,232(sp)
    8000790c:	0ff13823          	sd	t6,240(sp)
    80007910:	cd5ff0ef          	jal	ra,800075e4 <kerneltrap>
    80007914:	00013083          	ld	ra,0(sp)
    80007918:	00813103          	ld	sp,8(sp)
    8000791c:	01013183          	ld	gp,16(sp)
    80007920:	02013283          	ld	t0,32(sp)
    80007924:	02813303          	ld	t1,40(sp)
    80007928:	03013383          	ld	t2,48(sp)
    8000792c:	03813403          	ld	s0,56(sp)
    80007930:	04013483          	ld	s1,64(sp)
    80007934:	04813503          	ld	a0,72(sp)
    80007938:	05013583          	ld	a1,80(sp)
    8000793c:	05813603          	ld	a2,88(sp)
    80007940:	06013683          	ld	a3,96(sp)
    80007944:	06813703          	ld	a4,104(sp)
    80007948:	07013783          	ld	a5,112(sp)
    8000794c:	07813803          	ld	a6,120(sp)
    80007950:	08013883          	ld	a7,128(sp)
    80007954:	08813903          	ld	s2,136(sp)
    80007958:	09013983          	ld	s3,144(sp)
    8000795c:	09813a03          	ld	s4,152(sp)
    80007960:	0a013a83          	ld	s5,160(sp)
    80007964:	0a813b03          	ld	s6,168(sp)
    80007968:	0b013b83          	ld	s7,176(sp)
    8000796c:	0b813c03          	ld	s8,184(sp)
    80007970:	0c013c83          	ld	s9,192(sp)
    80007974:	0c813d03          	ld	s10,200(sp)
    80007978:	0d013d83          	ld	s11,208(sp)
    8000797c:	0d813e03          	ld	t3,216(sp)
    80007980:	0e013e83          	ld	t4,224(sp)
    80007984:	0e813f03          	ld	t5,232(sp)
    80007988:	0f013f83          	ld	t6,240(sp)
    8000798c:	10010113          	addi	sp,sp,256
    80007990:	10200073          	sret
    80007994:	00000013          	nop
    80007998:	00000013          	nop
    8000799c:	00000013          	nop

00000000800079a0 <timervec>:
    800079a0:	34051573          	csrrw	a0,mscratch,a0
    800079a4:	00b53023          	sd	a1,0(a0)
    800079a8:	00c53423          	sd	a2,8(a0)
    800079ac:	00d53823          	sd	a3,16(a0)
    800079b0:	01853583          	ld	a1,24(a0)
    800079b4:	02053603          	ld	a2,32(a0)
    800079b8:	0005b683          	ld	a3,0(a1)
    800079bc:	00c686b3          	add	a3,a3,a2
    800079c0:	00d5b023          	sd	a3,0(a1)
    800079c4:	00200593          	li	a1,2
    800079c8:	14459073          	csrw	sip,a1
    800079cc:	01053683          	ld	a3,16(a0)
    800079d0:	00853603          	ld	a2,8(a0)
    800079d4:	00053583          	ld	a1,0(a0)
    800079d8:	34051573          	csrrw	a0,mscratch,a0
    800079dc:	30200073          	mret

00000000800079e0 <plicinit>:
    800079e0:	ff010113          	addi	sp,sp,-16
    800079e4:	00813423          	sd	s0,8(sp)
    800079e8:	01010413          	addi	s0,sp,16
    800079ec:	00813403          	ld	s0,8(sp)
    800079f0:	0c0007b7          	lui	a5,0xc000
    800079f4:	00100713          	li	a4,1
    800079f8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800079fc:	00e7a223          	sw	a4,4(a5)
    80007a00:	01010113          	addi	sp,sp,16
    80007a04:	00008067          	ret

0000000080007a08 <plicinithart>:
    80007a08:	ff010113          	addi	sp,sp,-16
    80007a0c:	00813023          	sd	s0,0(sp)
    80007a10:	00113423          	sd	ra,8(sp)
    80007a14:	01010413          	addi	s0,sp,16
    80007a18:	00000097          	auipc	ra,0x0
    80007a1c:	a4c080e7          	jalr	-1460(ra) # 80007464 <cpuid>
    80007a20:	0085171b          	slliw	a4,a0,0x8
    80007a24:	0c0027b7          	lui	a5,0xc002
    80007a28:	00e787b3          	add	a5,a5,a4
    80007a2c:	40200713          	li	a4,1026
    80007a30:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007a34:	00813083          	ld	ra,8(sp)
    80007a38:	00013403          	ld	s0,0(sp)
    80007a3c:	00d5151b          	slliw	a0,a0,0xd
    80007a40:	0c2017b7          	lui	a5,0xc201
    80007a44:	00a78533          	add	a0,a5,a0
    80007a48:	00052023          	sw	zero,0(a0)
    80007a4c:	01010113          	addi	sp,sp,16
    80007a50:	00008067          	ret

0000000080007a54 <plic_claim>:
    80007a54:	ff010113          	addi	sp,sp,-16
    80007a58:	00813023          	sd	s0,0(sp)
    80007a5c:	00113423          	sd	ra,8(sp)
    80007a60:	01010413          	addi	s0,sp,16
    80007a64:	00000097          	auipc	ra,0x0
    80007a68:	a00080e7          	jalr	-1536(ra) # 80007464 <cpuid>
    80007a6c:	00813083          	ld	ra,8(sp)
    80007a70:	00013403          	ld	s0,0(sp)
    80007a74:	00d5151b          	slliw	a0,a0,0xd
    80007a78:	0c2017b7          	lui	a5,0xc201
    80007a7c:	00a78533          	add	a0,a5,a0
    80007a80:	00452503          	lw	a0,4(a0)
    80007a84:	01010113          	addi	sp,sp,16
    80007a88:	00008067          	ret

0000000080007a8c <plic_complete>:
    80007a8c:	fe010113          	addi	sp,sp,-32
    80007a90:	00813823          	sd	s0,16(sp)
    80007a94:	00913423          	sd	s1,8(sp)
    80007a98:	00113c23          	sd	ra,24(sp)
    80007a9c:	02010413          	addi	s0,sp,32
    80007aa0:	00050493          	mv	s1,a0
    80007aa4:	00000097          	auipc	ra,0x0
    80007aa8:	9c0080e7          	jalr	-1600(ra) # 80007464 <cpuid>
    80007aac:	01813083          	ld	ra,24(sp)
    80007ab0:	01013403          	ld	s0,16(sp)
    80007ab4:	00d5179b          	slliw	a5,a0,0xd
    80007ab8:	0c201737          	lui	a4,0xc201
    80007abc:	00f707b3          	add	a5,a4,a5
    80007ac0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007ac4:	00813483          	ld	s1,8(sp)
    80007ac8:	02010113          	addi	sp,sp,32
    80007acc:	00008067          	ret

0000000080007ad0 <consolewrite>:
    80007ad0:	fb010113          	addi	sp,sp,-80
    80007ad4:	04813023          	sd	s0,64(sp)
    80007ad8:	04113423          	sd	ra,72(sp)
    80007adc:	02913c23          	sd	s1,56(sp)
    80007ae0:	03213823          	sd	s2,48(sp)
    80007ae4:	03313423          	sd	s3,40(sp)
    80007ae8:	03413023          	sd	s4,32(sp)
    80007aec:	01513c23          	sd	s5,24(sp)
    80007af0:	05010413          	addi	s0,sp,80
    80007af4:	06c05c63          	blez	a2,80007b6c <consolewrite+0x9c>
    80007af8:	00060993          	mv	s3,a2
    80007afc:	00050a13          	mv	s4,a0
    80007b00:	00058493          	mv	s1,a1
    80007b04:	00000913          	li	s2,0
    80007b08:	fff00a93          	li	s5,-1
    80007b0c:	01c0006f          	j	80007b28 <consolewrite+0x58>
    80007b10:	fbf44503          	lbu	a0,-65(s0)
    80007b14:	0019091b          	addiw	s2,s2,1
    80007b18:	00148493          	addi	s1,s1,1
    80007b1c:	00001097          	auipc	ra,0x1
    80007b20:	a9c080e7          	jalr	-1380(ra) # 800085b8 <uartputc>
    80007b24:	03298063          	beq	s3,s2,80007b44 <consolewrite+0x74>
    80007b28:	00048613          	mv	a2,s1
    80007b2c:	00100693          	li	a3,1
    80007b30:	000a0593          	mv	a1,s4
    80007b34:	fbf40513          	addi	a0,s0,-65
    80007b38:	00000097          	auipc	ra,0x0
    80007b3c:	9e4080e7          	jalr	-1564(ra) # 8000751c <either_copyin>
    80007b40:	fd5518e3          	bne	a0,s5,80007b10 <consolewrite+0x40>
    80007b44:	04813083          	ld	ra,72(sp)
    80007b48:	04013403          	ld	s0,64(sp)
    80007b4c:	03813483          	ld	s1,56(sp)
    80007b50:	02813983          	ld	s3,40(sp)
    80007b54:	02013a03          	ld	s4,32(sp)
    80007b58:	01813a83          	ld	s5,24(sp)
    80007b5c:	00090513          	mv	a0,s2
    80007b60:	03013903          	ld	s2,48(sp)
    80007b64:	05010113          	addi	sp,sp,80
    80007b68:	00008067          	ret
    80007b6c:	00000913          	li	s2,0
    80007b70:	fd5ff06f          	j	80007b44 <consolewrite+0x74>

0000000080007b74 <consoleread>:
    80007b74:	f9010113          	addi	sp,sp,-112
    80007b78:	06813023          	sd	s0,96(sp)
    80007b7c:	04913c23          	sd	s1,88(sp)
    80007b80:	05213823          	sd	s2,80(sp)
    80007b84:	05313423          	sd	s3,72(sp)
    80007b88:	05413023          	sd	s4,64(sp)
    80007b8c:	03513c23          	sd	s5,56(sp)
    80007b90:	03613823          	sd	s6,48(sp)
    80007b94:	03713423          	sd	s7,40(sp)
    80007b98:	03813023          	sd	s8,32(sp)
    80007b9c:	06113423          	sd	ra,104(sp)
    80007ba0:	01913c23          	sd	s9,24(sp)
    80007ba4:	07010413          	addi	s0,sp,112
    80007ba8:	00060b93          	mv	s7,a2
    80007bac:	00050913          	mv	s2,a0
    80007bb0:	00058c13          	mv	s8,a1
    80007bb4:	00060b1b          	sext.w	s6,a2
    80007bb8:	00006497          	auipc	s1,0x6
    80007bbc:	2a048493          	addi	s1,s1,672 # 8000de58 <cons>
    80007bc0:	00400993          	li	s3,4
    80007bc4:	fff00a13          	li	s4,-1
    80007bc8:	00a00a93          	li	s5,10
    80007bcc:	05705e63          	blez	s7,80007c28 <consoleread+0xb4>
    80007bd0:	09c4a703          	lw	a4,156(s1)
    80007bd4:	0984a783          	lw	a5,152(s1)
    80007bd8:	0007071b          	sext.w	a4,a4
    80007bdc:	08e78463          	beq	a5,a4,80007c64 <consoleread+0xf0>
    80007be0:	07f7f713          	andi	a4,a5,127
    80007be4:	00e48733          	add	a4,s1,a4
    80007be8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80007bec:	0017869b          	addiw	a3,a5,1
    80007bf0:	08d4ac23          	sw	a3,152(s1)
    80007bf4:	00070c9b          	sext.w	s9,a4
    80007bf8:	0b370663          	beq	a4,s3,80007ca4 <consoleread+0x130>
    80007bfc:	00100693          	li	a3,1
    80007c00:	f9f40613          	addi	a2,s0,-97
    80007c04:	000c0593          	mv	a1,s8
    80007c08:	00090513          	mv	a0,s2
    80007c0c:	f8e40fa3          	sb	a4,-97(s0)
    80007c10:	00000097          	auipc	ra,0x0
    80007c14:	8c0080e7          	jalr	-1856(ra) # 800074d0 <either_copyout>
    80007c18:	01450863          	beq	a0,s4,80007c28 <consoleread+0xb4>
    80007c1c:	001c0c13          	addi	s8,s8,1
    80007c20:	fffb8b9b          	addiw	s7,s7,-1
    80007c24:	fb5c94e3          	bne	s9,s5,80007bcc <consoleread+0x58>
    80007c28:	000b851b          	sext.w	a0,s7
    80007c2c:	06813083          	ld	ra,104(sp)
    80007c30:	06013403          	ld	s0,96(sp)
    80007c34:	05813483          	ld	s1,88(sp)
    80007c38:	05013903          	ld	s2,80(sp)
    80007c3c:	04813983          	ld	s3,72(sp)
    80007c40:	04013a03          	ld	s4,64(sp)
    80007c44:	03813a83          	ld	s5,56(sp)
    80007c48:	02813b83          	ld	s7,40(sp)
    80007c4c:	02013c03          	ld	s8,32(sp)
    80007c50:	01813c83          	ld	s9,24(sp)
    80007c54:	40ab053b          	subw	a0,s6,a0
    80007c58:	03013b03          	ld	s6,48(sp)
    80007c5c:	07010113          	addi	sp,sp,112
    80007c60:	00008067          	ret
    80007c64:	00001097          	auipc	ra,0x1
    80007c68:	1d8080e7          	jalr	472(ra) # 80008e3c <push_on>
    80007c6c:	0984a703          	lw	a4,152(s1)
    80007c70:	09c4a783          	lw	a5,156(s1)
    80007c74:	0007879b          	sext.w	a5,a5
    80007c78:	fef70ce3          	beq	a4,a5,80007c70 <consoleread+0xfc>
    80007c7c:	00001097          	auipc	ra,0x1
    80007c80:	234080e7          	jalr	564(ra) # 80008eb0 <pop_on>
    80007c84:	0984a783          	lw	a5,152(s1)
    80007c88:	07f7f713          	andi	a4,a5,127
    80007c8c:	00e48733          	add	a4,s1,a4
    80007c90:	01874703          	lbu	a4,24(a4)
    80007c94:	0017869b          	addiw	a3,a5,1
    80007c98:	08d4ac23          	sw	a3,152(s1)
    80007c9c:	00070c9b          	sext.w	s9,a4
    80007ca0:	f5371ee3          	bne	a4,s3,80007bfc <consoleread+0x88>
    80007ca4:	000b851b          	sext.w	a0,s7
    80007ca8:	f96bf2e3          	bgeu	s7,s6,80007c2c <consoleread+0xb8>
    80007cac:	08f4ac23          	sw	a5,152(s1)
    80007cb0:	f7dff06f          	j	80007c2c <consoleread+0xb8>

0000000080007cb4 <consputc>:
    80007cb4:	10000793          	li	a5,256
    80007cb8:	00f50663          	beq	a0,a5,80007cc4 <consputc+0x10>
    80007cbc:	00001317          	auipc	t1,0x1
    80007cc0:	9f430067          	jr	-1548(t1) # 800086b0 <uartputc_sync>
    80007cc4:	ff010113          	addi	sp,sp,-16
    80007cc8:	00113423          	sd	ra,8(sp)
    80007ccc:	00813023          	sd	s0,0(sp)
    80007cd0:	01010413          	addi	s0,sp,16
    80007cd4:	00800513          	li	a0,8
    80007cd8:	00001097          	auipc	ra,0x1
    80007cdc:	9d8080e7          	jalr	-1576(ra) # 800086b0 <uartputc_sync>
    80007ce0:	02000513          	li	a0,32
    80007ce4:	00001097          	auipc	ra,0x1
    80007ce8:	9cc080e7          	jalr	-1588(ra) # 800086b0 <uartputc_sync>
    80007cec:	00013403          	ld	s0,0(sp)
    80007cf0:	00813083          	ld	ra,8(sp)
    80007cf4:	00800513          	li	a0,8
    80007cf8:	01010113          	addi	sp,sp,16
    80007cfc:	00001317          	auipc	t1,0x1
    80007d00:	9b430067          	jr	-1612(t1) # 800086b0 <uartputc_sync>

0000000080007d04 <consoleintr>:
    80007d04:	fe010113          	addi	sp,sp,-32
    80007d08:	00813823          	sd	s0,16(sp)
    80007d0c:	00913423          	sd	s1,8(sp)
    80007d10:	01213023          	sd	s2,0(sp)
    80007d14:	00113c23          	sd	ra,24(sp)
    80007d18:	02010413          	addi	s0,sp,32
    80007d1c:	00006917          	auipc	s2,0x6
    80007d20:	13c90913          	addi	s2,s2,316 # 8000de58 <cons>
    80007d24:	00050493          	mv	s1,a0
    80007d28:	00090513          	mv	a0,s2
    80007d2c:	00001097          	auipc	ra,0x1
    80007d30:	e40080e7          	jalr	-448(ra) # 80008b6c <acquire>
    80007d34:	02048c63          	beqz	s1,80007d6c <consoleintr+0x68>
    80007d38:	0a092783          	lw	a5,160(s2)
    80007d3c:	09892703          	lw	a4,152(s2)
    80007d40:	07f00693          	li	a3,127
    80007d44:	40e7873b          	subw	a4,a5,a4
    80007d48:	02e6e263          	bltu	a3,a4,80007d6c <consoleintr+0x68>
    80007d4c:	00d00713          	li	a4,13
    80007d50:	04e48063          	beq	s1,a4,80007d90 <consoleintr+0x8c>
    80007d54:	07f7f713          	andi	a4,a5,127
    80007d58:	00e90733          	add	a4,s2,a4
    80007d5c:	0017879b          	addiw	a5,a5,1
    80007d60:	0af92023          	sw	a5,160(s2)
    80007d64:	00970c23          	sb	s1,24(a4)
    80007d68:	08f92e23          	sw	a5,156(s2)
    80007d6c:	01013403          	ld	s0,16(sp)
    80007d70:	01813083          	ld	ra,24(sp)
    80007d74:	00813483          	ld	s1,8(sp)
    80007d78:	00013903          	ld	s2,0(sp)
    80007d7c:	00006517          	auipc	a0,0x6
    80007d80:	0dc50513          	addi	a0,a0,220 # 8000de58 <cons>
    80007d84:	02010113          	addi	sp,sp,32
    80007d88:	00001317          	auipc	t1,0x1
    80007d8c:	eb030067          	jr	-336(t1) # 80008c38 <release>
    80007d90:	00a00493          	li	s1,10
    80007d94:	fc1ff06f          	j	80007d54 <consoleintr+0x50>

0000000080007d98 <consoleinit>:
    80007d98:	fe010113          	addi	sp,sp,-32
    80007d9c:	00113c23          	sd	ra,24(sp)
    80007da0:	00813823          	sd	s0,16(sp)
    80007da4:	00913423          	sd	s1,8(sp)
    80007da8:	02010413          	addi	s0,sp,32
    80007dac:	00006497          	auipc	s1,0x6
    80007db0:	0ac48493          	addi	s1,s1,172 # 8000de58 <cons>
    80007db4:	00048513          	mv	a0,s1
    80007db8:	00003597          	auipc	a1,0x3
    80007dbc:	8a058593          	addi	a1,a1,-1888 # 8000a658 <CONSOLE_STATUS+0x648>
    80007dc0:	00001097          	auipc	ra,0x1
    80007dc4:	d88080e7          	jalr	-632(ra) # 80008b48 <initlock>
    80007dc8:	00000097          	auipc	ra,0x0
    80007dcc:	7ac080e7          	jalr	1964(ra) # 80008574 <uartinit>
    80007dd0:	01813083          	ld	ra,24(sp)
    80007dd4:	01013403          	ld	s0,16(sp)
    80007dd8:	00000797          	auipc	a5,0x0
    80007ddc:	d9c78793          	addi	a5,a5,-612 # 80007b74 <consoleread>
    80007de0:	0af4bc23          	sd	a5,184(s1)
    80007de4:	00000797          	auipc	a5,0x0
    80007de8:	cec78793          	addi	a5,a5,-788 # 80007ad0 <consolewrite>
    80007dec:	0cf4b023          	sd	a5,192(s1)
    80007df0:	00813483          	ld	s1,8(sp)
    80007df4:	02010113          	addi	sp,sp,32
    80007df8:	00008067          	ret

0000000080007dfc <console_read>:
    80007dfc:	ff010113          	addi	sp,sp,-16
    80007e00:	00813423          	sd	s0,8(sp)
    80007e04:	01010413          	addi	s0,sp,16
    80007e08:	00813403          	ld	s0,8(sp)
    80007e0c:	00006317          	auipc	t1,0x6
    80007e10:	10433303          	ld	t1,260(t1) # 8000df10 <devsw+0x10>
    80007e14:	01010113          	addi	sp,sp,16
    80007e18:	00030067          	jr	t1

0000000080007e1c <console_write>:
    80007e1c:	ff010113          	addi	sp,sp,-16
    80007e20:	00813423          	sd	s0,8(sp)
    80007e24:	01010413          	addi	s0,sp,16
    80007e28:	00813403          	ld	s0,8(sp)
    80007e2c:	00006317          	auipc	t1,0x6
    80007e30:	0ec33303          	ld	t1,236(t1) # 8000df18 <devsw+0x18>
    80007e34:	01010113          	addi	sp,sp,16
    80007e38:	00030067          	jr	t1

0000000080007e3c <panic>:
    80007e3c:	fe010113          	addi	sp,sp,-32
    80007e40:	00113c23          	sd	ra,24(sp)
    80007e44:	00813823          	sd	s0,16(sp)
    80007e48:	00913423          	sd	s1,8(sp)
    80007e4c:	02010413          	addi	s0,sp,32
    80007e50:	00050493          	mv	s1,a0
    80007e54:	00003517          	auipc	a0,0x3
    80007e58:	80c50513          	addi	a0,a0,-2036 # 8000a660 <CONSOLE_STATUS+0x650>
    80007e5c:	00006797          	auipc	a5,0x6
    80007e60:	1407ae23          	sw	zero,348(a5) # 8000dfb8 <pr+0x18>
    80007e64:	00000097          	auipc	ra,0x0
    80007e68:	034080e7          	jalr	52(ra) # 80007e98 <__printf>
    80007e6c:	00048513          	mv	a0,s1
    80007e70:	00000097          	auipc	ra,0x0
    80007e74:	028080e7          	jalr	40(ra) # 80007e98 <__printf>
    80007e78:	00002517          	auipc	a0,0x2
    80007e7c:	57050513          	addi	a0,a0,1392 # 8000a3e8 <CONSOLE_STATUS+0x3d8>
    80007e80:	00000097          	auipc	ra,0x0
    80007e84:	018080e7          	jalr	24(ra) # 80007e98 <__printf>
    80007e88:	00100793          	li	a5,1
    80007e8c:	00005717          	auipc	a4,0x5
    80007e90:	def72e23          	sw	a5,-516(a4) # 8000cc88 <panicked>
    80007e94:	0000006f          	j	80007e94 <panic+0x58>

0000000080007e98 <__printf>:
    80007e98:	f3010113          	addi	sp,sp,-208
    80007e9c:	08813023          	sd	s0,128(sp)
    80007ea0:	07313423          	sd	s3,104(sp)
    80007ea4:	09010413          	addi	s0,sp,144
    80007ea8:	05813023          	sd	s8,64(sp)
    80007eac:	08113423          	sd	ra,136(sp)
    80007eb0:	06913c23          	sd	s1,120(sp)
    80007eb4:	07213823          	sd	s2,112(sp)
    80007eb8:	07413023          	sd	s4,96(sp)
    80007ebc:	05513c23          	sd	s5,88(sp)
    80007ec0:	05613823          	sd	s6,80(sp)
    80007ec4:	05713423          	sd	s7,72(sp)
    80007ec8:	03913c23          	sd	s9,56(sp)
    80007ecc:	03a13823          	sd	s10,48(sp)
    80007ed0:	03b13423          	sd	s11,40(sp)
    80007ed4:	00006317          	auipc	t1,0x6
    80007ed8:	0cc30313          	addi	t1,t1,204 # 8000dfa0 <pr>
    80007edc:	01832c03          	lw	s8,24(t1)
    80007ee0:	00b43423          	sd	a1,8(s0)
    80007ee4:	00c43823          	sd	a2,16(s0)
    80007ee8:	00d43c23          	sd	a3,24(s0)
    80007eec:	02e43023          	sd	a4,32(s0)
    80007ef0:	02f43423          	sd	a5,40(s0)
    80007ef4:	03043823          	sd	a6,48(s0)
    80007ef8:	03143c23          	sd	a7,56(s0)
    80007efc:	00050993          	mv	s3,a0
    80007f00:	4a0c1663          	bnez	s8,800083ac <__printf+0x514>
    80007f04:	60098c63          	beqz	s3,8000851c <__printf+0x684>
    80007f08:	0009c503          	lbu	a0,0(s3)
    80007f0c:	00840793          	addi	a5,s0,8
    80007f10:	f6f43c23          	sd	a5,-136(s0)
    80007f14:	00000493          	li	s1,0
    80007f18:	22050063          	beqz	a0,80008138 <__printf+0x2a0>
    80007f1c:	00002a37          	lui	s4,0x2
    80007f20:	00018ab7          	lui	s5,0x18
    80007f24:	000f4b37          	lui	s6,0xf4
    80007f28:	00989bb7          	lui	s7,0x989
    80007f2c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007f30:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007f34:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007f38:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80007f3c:	00148c9b          	addiw	s9,s1,1
    80007f40:	02500793          	li	a5,37
    80007f44:	01998933          	add	s2,s3,s9
    80007f48:	38f51263          	bne	a0,a5,800082cc <__printf+0x434>
    80007f4c:	00094783          	lbu	a5,0(s2)
    80007f50:	00078c9b          	sext.w	s9,a5
    80007f54:	1e078263          	beqz	a5,80008138 <__printf+0x2a0>
    80007f58:	0024849b          	addiw	s1,s1,2
    80007f5c:	07000713          	li	a4,112
    80007f60:	00998933          	add	s2,s3,s1
    80007f64:	38e78a63          	beq	a5,a4,800082f8 <__printf+0x460>
    80007f68:	20f76863          	bltu	a4,a5,80008178 <__printf+0x2e0>
    80007f6c:	42a78863          	beq	a5,a0,8000839c <__printf+0x504>
    80007f70:	06400713          	li	a4,100
    80007f74:	40e79663          	bne	a5,a4,80008380 <__printf+0x4e8>
    80007f78:	f7843783          	ld	a5,-136(s0)
    80007f7c:	0007a603          	lw	a2,0(a5)
    80007f80:	00878793          	addi	a5,a5,8
    80007f84:	f6f43c23          	sd	a5,-136(s0)
    80007f88:	42064a63          	bltz	a2,800083bc <__printf+0x524>
    80007f8c:	00a00713          	li	a4,10
    80007f90:	02e677bb          	remuw	a5,a2,a4
    80007f94:	00002d97          	auipc	s11,0x2
    80007f98:	6f4d8d93          	addi	s11,s11,1780 # 8000a688 <digits>
    80007f9c:	00900593          	li	a1,9
    80007fa0:	0006051b          	sext.w	a0,a2
    80007fa4:	00000c93          	li	s9,0
    80007fa8:	02079793          	slli	a5,a5,0x20
    80007fac:	0207d793          	srli	a5,a5,0x20
    80007fb0:	00fd87b3          	add	a5,s11,a5
    80007fb4:	0007c783          	lbu	a5,0(a5)
    80007fb8:	02e656bb          	divuw	a3,a2,a4
    80007fbc:	f8f40023          	sb	a5,-128(s0)
    80007fc0:	14c5d863          	bge	a1,a2,80008110 <__printf+0x278>
    80007fc4:	06300593          	li	a1,99
    80007fc8:	00100c93          	li	s9,1
    80007fcc:	02e6f7bb          	remuw	a5,a3,a4
    80007fd0:	02079793          	slli	a5,a5,0x20
    80007fd4:	0207d793          	srli	a5,a5,0x20
    80007fd8:	00fd87b3          	add	a5,s11,a5
    80007fdc:	0007c783          	lbu	a5,0(a5)
    80007fe0:	02e6d73b          	divuw	a4,a3,a4
    80007fe4:	f8f400a3          	sb	a5,-127(s0)
    80007fe8:	12a5f463          	bgeu	a1,a0,80008110 <__printf+0x278>
    80007fec:	00a00693          	li	a3,10
    80007ff0:	00900593          	li	a1,9
    80007ff4:	02d777bb          	remuw	a5,a4,a3
    80007ff8:	02079793          	slli	a5,a5,0x20
    80007ffc:	0207d793          	srli	a5,a5,0x20
    80008000:	00fd87b3          	add	a5,s11,a5
    80008004:	0007c503          	lbu	a0,0(a5)
    80008008:	02d757bb          	divuw	a5,a4,a3
    8000800c:	f8a40123          	sb	a0,-126(s0)
    80008010:	48e5f263          	bgeu	a1,a4,80008494 <__printf+0x5fc>
    80008014:	06300513          	li	a0,99
    80008018:	02d7f5bb          	remuw	a1,a5,a3
    8000801c:	02059593          	slli	a1,a1,0x20
    80008020:	0205d593          	srli	a1,a1,0x20
    80008024:	00bd85b3          	add	a1,s11,a1
    80008028:	0005c583          	lbu	a1,0(a1)
    8000802c:	02d7d7bb          	divuw	a5,a5,a3
    80008030:	f8b401a3          	sb	a1,-125(s0)
    80008034:	48e57263          	bgeu	a0,a4,800084b8 <__printf+0x620>
    80008038:	3e700513          	li	a0,999
    8000803c:	02d7f5bb          	remuw	a1,a5,a3
    80008040:	02059593          	slli	a1,a1,0x20
    80008044:	0205d593          	srli	a1,a1,0x20
    80008048:	00bd85b3          	add	a1,s11,a1
    8000804c:	0005c583          	lbu	a1,0(a1)
    80008050:	02d7d7bb          	divuw	a5,a5,a3
    80008054:	f8b40223          	sb	a1,-124(s0)
    80008058:	46e57663          	bgeu	a0,a4,800084c4 <__printf+0x62c>
    8000805c:	02d7f5bb          	remuw	a1,a5,a3
    80008060:	02059593          	slli	a1,a1,0x20
    80008064:	0205d593          	srli	a1,a1,0x20
    80008068:	00bd85b3          	add	a1,s11,a1
    8000806c:	0005c583          	lbu	a1,0(a1)
    80008070:	02d7d7bb          	divuw	a5,a5,a3
    80008074:	f8b402a3          	sb	a1,-123(s0)
    80008078:	46ea7863          	bgeu	s4,a4,800084e8 <__printf+0x650>
    8000807c:	02d7f5bb          	remuw	a1,a5,a3
    80008080:	02059593          	slli	a1,a1,0x20
    80008084:	0205d593          	srli	a1,a1,0x20
    80008088:	00bd85b3          	add	a1,s11,a1
    8000808c:	0005c583          	lbu	a1,0(a1)
    80008090:	02d7d7bb          	divuw	a5,a5,a3
    80008094:	f8b40323          	sb	a1,-122(s0)
    80008098:	3eeaf863          	bgeu	s5,a4,80008488 <__printf+0x5f0>
    8000809c:	02d7f5bb          	remuw	a1,a5,a3
    800080a0:	02059593          	slli	a1,a1,0x20
    800080a4:	0205d593          	srli	a1,a1,0x20
    800080a8:	00bd85b3          	add	a1,s11,a1
    800080ac:	0005c583          	lbu	a1,0(a1)
    800080b0:	02d7d7bb          	divuw	a5,a5,a3
    800080b4:	f8b403a3          	sb	a1,-121(s0)
    800080b8:	42eb7e63          	bgeu	s6,a4,800084f4 <__printf+0x65c>
    800080bc:	02d7f5bb          	remuw	a1,a5,a3
    800080c0:	02059593          	slli	a1,a1,0x20
    800080c4:	0205d593          	srli	a1,a1,0x20
    800080c8:	00bd85b3          	add	a1,s11,a1
    800080cc:	0005c583          	lbu	a1,0(a1)
    800080d0:	02d7d7bb          	divuw	a5,a5,a3
    800080d4:	f8b40423          	sb	a1,-120(s0)
    800080d8:	42ebfc63          	bgeu	s7,a4,80008510 <__printf+0x678>
    800080dc:	02079793          	slli	a5,a5,0x20
    800080e0:	0207d793          	srli	a5,a5,0x20
    800080e4:	00fd8db3          	add	s11,s11,a5
    800080e8:	000dc703          	lbu	a4,0(s11)
    800080ec:	00a00793          	li	a5,10
    800080f0:	00900c93          	li	s9,9
    800080f4:	f8e404a3          	sb	a4,-119(s0)
    800080f8:	00065c63          	bgez	a2,80008110 <__printf+0x278>
    800080fc:	f9040713          	addi	a4,s0,-112
    80008100:	00f70733          	add	a4,a4,a5
    80008104:	02d00693          	li	a3,45
    80008108:	fed70823          	sb	a3,-16(a4)
    8000810c:	00078c93          	mv	s9,a5
    80008110:	f8040793          	addi	a5,s0,-128
    80008114:	01978cb3          	add	s9,a5,s9
    80008118:	f7f40d13          	addi	s10,s0,-129
    8000811c:	000cc503          	lbu	a0,0(s9)
    80008120:	fffc8c93          	addi	s9,s9,-1
    80008124:	00000097          	auipc	ra,0x0
    80008128:	b90080e7          	jalr	-1136(ra) # 80007cb4 <consputc>
    8000812c:	ffac98e3          	bne	s9,s10,8000811c <__printf+0x284>
    80008130:	00094503          	lbu	a0,0(s2)
    80008134:	e00514e3          	bnez	a0,80007f3c <__printf+0xa4>
    80008138:	1a0c1663          	bnez	s8,800082e4 <__printf+0x44c>
    8000813c:	08813083          	ld	ra,136(sp)
    80008140:	08013403          	ld	s0,128(sp)
    80008144:	07813483          	ld	s1,120(sp)
    80008148:	07013903          	ld	s2,112(sp)
    8000814c:	06813983          	ld	s3,104(sp)
    80008150:	06013a03          	ld	s4,96(sp)
    80008154:	05813a83          	ld	s5,88(sp)
    80008158:	05013b03          	ld	s6,80(sp)
    8000815c:	04813b83          	ld	s7,72(sp)
    80008160:	04013c03          	ld	s8,64(sp)
    80008164:	03813c83          	ld	s9,56(sp)
    80008168:	03013d03          	ld	s10,48(sp)
    8000816c:	02813d83          	ld	s11,40(sp)
    80008170:	0d010113          	addi	sp,sp,208
    80008174:	00008067          	ret
    80008178:	07300713          	li	a4,115
    8000817c:	1ce78a63          	beq	a5,a4,80008350 <__printf+0x4b8>
    80008180:	07800713          	li	a4,120
    80008184:	1ee79e63          	bne	a5,a4,80008380 <__printf+0x4e8>
    80008188:	f7843783          	ld	a5,-136(s0)
    8000818c:	0007a703          	lw	a4,0(a5)
    80008190:	00878793          	addi	a5,a5,8
    80008194:	f6f43c23          	sd	a5,-136(s0)
    80008198:	28074263          	bltz	a4,8000841c <__printf+0x584>
    8000819c:	00002d97          	auipc	s11,0x2
    800081a0:	4ecd8d93          	addi	s11,s11,1260 # 8000a688 <digits>
    800081a4:	00f77793          	andi	a5,a4,15
    800081a8:	00fd87b3          	add	a5,s11,a5
    800081ac:	0007c683          	lbu	a3,0(a5)
    800081b0:	00f00613          	li	a2,15
    800081b4:	0007079b          	sext.w	a5,a4
    800081b8:	f8d40023          	sb	a3,-128(s0)
    800081bc:	0047559b          	srliw	a1,a4,0x4
    800081c0:	0047569b          	srliw	a3,a4,0x4
    800081c4:	00000c93          	li	s9,0
    800081c8:	0ee65063          	bge	a2,a4,800082a8 <__printf+0x410>
    800081cc:	00f6f693          	andi	a3,a3,15
    800081d0:	00dd86b3          	add	a3,s11,a3
    800081d4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800081d8:	0087d79b          	srliw	a5,a5,0x8
    800081dc:	00100c93          	li	s9,1
    800081e0:	f8d400a3          	sb	a3,-127(s0)
    800081e4:	0cb67263          	bgeu	a2,a1,800082a8 <__printf+0x410>
    800081e8:	00f7f693          	andi	a3,a5,15
    800081ec:	00dd86b3          	add	a3,s11,a3
    800081f0:	0006c583          	lbu	a1,0(a3)
    800081f4:	00f00613          	li	a2,15
    800081f8:	0047d69b          	srliw	a3,a5,0x4
    800081fc:	f8b40123          	sb	a1,-126(s0)
    80008200:	0047d593          	srli	a1,a5,0x4
    80008204:	28f67e63          	bgeu	a2,a5,800084a0 <__printf+0x608>
    80008208:	00f6f693          	andi	a3,a3,15
    8000820c:	00dd86b3          	add	a3,s11,a3
    80008210:	0006c503          	lbu	a0,0(a3)
    80008214:	0087d813          	srli	a6,a5,0x8
    80008218:	0087d69b          	srliw	a3,a5,0x8
    8000821c:	f8a401a3          	sb	a0,-125(s0)
    80008220:	28b67663          	bgeu	a2,a1,800084ac <__printf+0x614>
    80008224:	00f6f693          	andi	a3,a3,15
    80008228:	00dd86b3          	add	a3,s11,a3
    8000822c:	0006c583          	lbu	a1,0(a3)
    80008230:	00c7d513          	srli	a0,a5,0xc
    80008234:	00c7d69b          	srliw	a3,a5,0xc
    80008238:	f8b40223          	sb	a1,-124(s0)
    8000823c:	29067a63          	bgeu	a2,a6,800084d0 <__printf+0x638>
    80008240:	00f6f693          	andi	a3,a3,15
    80008244:	00dd86b3          	add	a3,s11,a3
    80008248:	0006c583          	lbu	a1,0(a3)
    8000824c:	0107d813          	srli	a6,a5,0x10
    80008250:	0107d69b          	srliw	a3,a5,0x10
    80008254:	f8b402a3          	sb	a1,-123(s0)
    80008258:	28a67263          	bgeu	a2,a0,800084dc <__printf+0x644>
    8000825c:	00f6f693          	andi	a3,a3,15
    80008260:	00dd86b3          	add	a3,s11,a3
    80008264:	0006c683          	lbu	a3,0(a3)
    80008268:	0147d79b          	srliw	a5,a5,0x14
    8000826c:	f8d40323          	sb	a3,-122(s0)
    80008270:	21067663          	bgeu	a2,a6,8000847c <__printf+0x5e4>
    80008274:	02079793          	slli	a5,a5,0x20
    80008278:	0207d793          	srli	a5,a5,0x20
    8000827c:	00fd8db3          	add	s11,s11,a5
    80008280:	000dc683          	lbu	a3,0(s11)
    80008284:	00800793          	li	a5,8
    80008288:	00700c93          	li	s9,7
    8000828c:	f8d403a3          	sb	a3,-121(s0)
    80008290:	00075c63          	bgez	a4,800082a8 <__printf+0x410>
    80008294:	f9040713          	addi	a4,s0,-112
    80008298:	00f70733          	add	a4,a4,a5
    8000829c:	02d00693          	li	a3,45
    800082a0:	fed70823          	sb	a3,-16(a4)
    800082a4:	00078c93          	mv	s9,a5
    800082a8:	f8040793          	addi	a5,s0,-128
    800082ac:	01978cb3          	add	s9,a5,s9
    800082b0:	f7f40d13          	addi	s10,s0,-129
    800082b4:	000cc503          	lbu	a0,0(s9)
    800082b8:	fffc8c93          	addi	s9,s9,-1
    800082bc:	00000097          	auipc	ra,0x0
    800082c0:	9f8080e7          	jalr	-1544(ra) # 80007cb4 <consputc>
    800082c4:	ff9d18e3          	bne	s10,s9,800082b4 <__printf+0x41c>
    800082c8:	0100006f          	j	800082d8 <__printf+0x440>
    800082cc:	00000097          	auipc	ra,0x0
    800082d0:	9e8080e7          	jalr	-1560(ra) # 80007cb4 <consputc>
    800082d4:	000c8493          	mv	s1,s9
    800082d8:	00094503          	lbu	a0,0(s2)
    800082dc:	c60510e3          	bnez	a0,80007f3c <__printf+0xa4>
    800082e0:	e40c0ee3          	beqz	s8,8000813c <__printf+0x2a4>
    800082e4:	00006517          	auipc	a0,0x6
    800082e8:	cbc50513          	addi	a0,a0,-836 # 8000dfa0 <pr>
    800082ec:	00001097          	auipc	ra,0x1
    800082f0:	94c080e7          	jalr	-1716(ra) # 80008c38 <release>
    800082f4:	e49ff06f          	j	8000813c <__printf+0x2a4>
    800082f8:	f7843783          	ld	a5,-136(s0)
    800082fc:	03000513          	li	a0,48
    80008300:	01000d13          	li	s10,16
    80008304:	00878713          	addi	a4,a5,8
    80008308:	0007bc83          	ld	s9,0(a5)
    8000830c:	f6e43c23          	sd	a4,-136(s0)
    80008310:	00000097          	auipc	ra,0x0
    80008314:	9a4080e7          	jalr	-1628(ra) # 80007cb4 <consputc>
    80008318:	07800513          	li	a0,120
    8000831c:	00000097          	auipc	ra,0x0
    80008320:	998080e7          	jalr	-1640(ra) # 80007cb4 <consputc>
    80008324:	00002d97          	auipc	s11,0x2
    80008328:	364d8d93          	addi	s11,s11,868 # 8000a688 <digits>
    8000832c:	03ccd793          	srli	a5,s9,0x3c
    80008330:	00fd87b3          	add	a5,s11,a5
    80008334:	0007c503          	lbu	a0,0(a5)
    80008338:	fffd0d1b          	addiw	s10,s10,-1
    8000833c:	004c9c93          	slli	s9,s9,0x4
    80008340:	00000097          	auipc	ra,0x0
    80008344:	974080e7          	jalr	-1676(ra) # 80007cb4 <consputc>
    80008348:	fe0d12e3          	bnez	s10,8000832c <__printf+0x494>
    8000834c:	f8dff06f          	j	800082d8 <__printf+0x440>
    80008350:	f7843783          	ld	a5,-136(s0)
    80008354:	0007bc83          	ld	s9,0(a5)
    80008358:	00878793          	addi	a5,a5,8
    8000835c:	f6f43c23          	sd	a5,-136(s0)
    80008360:	000c9a63          	bnez	s9,80008374 <__printf+0x4dc>
    80008364:	1080006f          	j	8000846c <__printf+0x5d4>
    80008368:	001c8c93          	addi	s9,s9,1
    8000836c:	00000097          	auipc	ra,0x0
    80008370:	948080e7          	jalr	-1720(ra) # 80007cb4 <consputc>
    80008374:	000cc503          	lbu	a0,0(s9)
    80008378:	fe0518e3          	bnez	a0,80008368 <__printf+0x4d0>
    8000837c:	f5dff06f          	j	800082d8 <__printf+0x440>
    80008380:	02500513          	li	a0,37
    80008384:	00000097          	auipc	ra,0x0
    80008388:	930080e7          	jalr	-1744(ra) # 80007cb4 <consputc>
    8000838c:	000c8513          	mv	a0,s9
    80008390:	00000097          	auipc	ra,0x0
    80008394:	924080e7          	jalr	-1756(ra) # 80007cb4 <consputc>
    80008398:	f41ff06f          	j	800082d8 <__printf+0x440>
    8000839c:	02500513          	li	a0,37
    800083a0:	00000097          	auipc	ra,0x0
    800083a4:	914080e7          	jalr	-1772(ra) # 80007cb4 <consputc>
    800083a8:	f31ff06f          	j	800082d8 <__printf+0x440>
    800083ac:	00030513          	mv	a0,t1
    800083b0:	00000097          	auipc	ra,0x0
    800083b4:	7bc080e7          	jalr	1980(ra) # 80008b6c <acquire>
    800083b8:	b4dff06f          	j	80007f04 <__printf+0x6c>
    800083bc:	40c0053b          	negw	a0,a2
    800083c0:	00a00713          	li	a4,10
    800083c4:	02e576bb          	remuw	a3,a0,a4
    800083c8:	00002d97          	auipc	s11,0x2
    800083cc:	2c0d8d93          	addi	s11,s11,704 # 8000a688 <digits>
    800083d0:	ff700593          	li	a1,-9
    800083d4:	02069693          	slli	a3,a3,0x20
    800083d8:	0206d693          	srli	a3,a3,0x20
    800083dc:	00dd86b3          	add	a3,s11,a3
    800083e0:	0006c683          	lbu	a3,0(a3)
    800083e4:	02e557bb          	divuw	a5,a0,a4
    800083e8:	f8d40023          	sb	a3,-128(s0)
    800083ec:	10b65e63          	bge	a2,a1,80008508 <__printf+0x670>
    800083f0:	06300593          	li	a1,99
    800083f4:	02e7f6bb          	remuw	a3,a5,a4
    800083f8:	02069693          	slli	a3,a3,0x20
    800083fc:	0206d693          	srli	a3,a3,0x20
    80008400:	00dd86b3          	add	a3,s11,a3
    80008404:	0006c683          	lbu	a3,0(a3)
    80008408:	02e7d73b          	divuw	a4,a5,a4
    8000840c:	00200793          	li	a5,2
    80008410:	f8d400a3          	sb	a3,-127(s0)
    80008414:	bca5ece3          	bltu	a1,a0,80007fec <__printf+0x154>
    80008418:	ce5ff06f          	j	800080fc <__printf+0x264>
    8000841c:	40e007bb          	negw	a5,a4
    80008420:	00002d97          	auipc	s11,0x2
    80008424:	268d8d93          	addi	s11,s11,616 # 8000a688 <digits>
    80008428:	00f7f693          	andi	a3,a5,15
    8000842c:	00dd86b3          	add	a3,s11,a3
    80008430:	0006c583          	lbu	a1,0(a3)
    80008434:	ff100613          	li	a2,-15
    80008438:	0047d69b          	srliw	a3,a5,0x4
    8000843c:	f8b40023          	sb	a1,-128(s0)
    80008440:	0047d59b          	srliw	a1,a5,0x4
    80008444:	0ac75e63          	bge	a4,a2,80008500 <__printf+0x668>
    80008448:	00f6f693          	andi	a3,a3,15
    8000844c:	00dd86b3          	add	a3,s11,a3
    80008450:	0006c603          	lbu	a2,0(a3)
    80008454:	00f00693          	li	a3,15
    80008458:	0087d79b          	srliw	a5,a5,0x8
    8000845c:	f8c400a3          	sb	a2,-127(s0)
    80008460:	d8b6e4e3          	bltu	a3,a1,800081e8 <__printf+0x350>
    80008464:	00200793          	li	a5,2
    80008468:	e2dff06f          	j	80008294 <__printf+0x3fc>
    8000846c:	00002c97          	auipc	s9,0x2
    80008470:	1fcc8c93          	addi	s9,s9,508 # 8000a668 <CONSOLE_STATUS+0x658>
    80008474:	02800513          	li	a0,40
    80008478:	ef1ff06f          	j	80008368 <__printf+0x4d0>
    8000847c:	00700793          	li	a5,7
    80008480:	00600c93          	li	s9,6
    80008484:	e0dff06f          	j	80008290 <__printf+0x3f8>
    80008488:	00700793          	li	a5,7
    8000848c:	00600c93          	li	s9,6
    80008490:	c69ff06f          	j	800080f8 <__printf+0x260>
    80008494:	00300793          	li	a5,3
    80008498:	00200c93          	li	s9,2
    8000849c:	c5dff06f          	j	800080f8 <__printf+0x260>
    800084a0:	00300793          	li	a5,3
    800084a4:	00200c93          	li	s9,2
    800084a8:	de9ff06f          	j	80008290 <__printf+0x3f8>
    800084ac:	00400793          	li	a5,4
    800084b0:	00300c93          	li	s9,3
    800084b4:	dddff06f          	j	80008290 <__printf+0x3f8>
    800084b8:	00400793          	li	a5,4
    800084bc:	00300c93          	li	s9,3
    800084c0:	c39ff06f          	j	800080f8 <__printf+0x260>
    800084c4:	00500793          	li	a5,5
    800084c8:	00400c93          	li	s9,4
    800084cc:	c2dff06f          	j	800080f8 <__printf+0x260>
    800084d0:	00500793          	li	a5,5
    800084d4:	00400c93          	li	s9,4
    800084d8:	db9ff06f          	j	80008290 <__printf+0x3f8>
    800084dc:	00600793          	li	a5,6
    800084e0:	00500c93          	li	s9,5
    800084e4:	dadff06f          	j	80008290 <__printf+0x3f8>
    800084e8:	00600793          	li	a5,6
    800084ec:	00500c93          	li	s9,5
    800084f0:	c09ff06f          	j	800080f8 <__printf+0x260>
    800084f4:	00800793          	li	a5,8
    800084f8:	00700c93          	li	s9,7
    800084fc:	bfdff06f          	j	800080f8 <__printf+0x260>
    80008500:	00100793          	li	a5,1
    80008504:	d91ff06f          	j	80008294 <__printf+0x3fc>
    80008508:	00100793          	li	a5,1
    8000850c:	bf1ff06f          	j	800080fc <__printf+0x264>
    80008510:	00900793          	li	a5,9
    80008514:	00800c93          	li	s9,8
    80008518:	be1ff06f          	j	800080f8 <__printf+0x260>
    8000851c:	00002517          	auipc	a0,0x2
    80008520:	15450513          	addi	a0,a0,340 # 8000a670 <CONSOLE_STATUS+0x660>
    80008524:	00000097          	auipc	ra,0x0
    80008528:	918080e7          	jalr	-1768(ra) # 80007e3c <panic>

000000008000852c <printfinit>:
    8000852c:	fe010113          	addi	sp,sp,-32
    80008530:	00813823          	sd	s0,16(sp)
    80008534:	00913423          	sd	s1,8(sp)
    80008538:	00113c23          	sd	ra,24(sp)
    8000853c:	02010413          	addi	s0,sp,32
    80008540:	00006497          	auipc	s1,0x6
    80008544:	a6048493          	addi	s1,s1,-1440 # 8000dfa0 <pr>
    80008548:	00048513          	mv	a0,s1
    8000854c:	00002597          	auipc	a1,0x2
    80008550:	13458593          	addi	a1,a1,308 # 8000a680 <CONSOLE_STATUS+0x670>
    80008554:	00000097          	auipc	ra,0x0
    80008558:	5f4080e7          	jalr	1524(ra) # 80008b48 <initlock>
    8000855c:	01813083          	ld	ra,24(sp)
    80008560:	01013403          	ld	s0,16(sp)
    80008564:	0004ac23          	sw	zero,24(s1)
    80008568:	00813483          	ld	s1,8(sp)
    8000856c:	02010113          	addi	sp,sp,32
    80008570:	00008067          	ret

0000000080008574 <uartinit>:
    80008574:	ff010113          	addi	sp,sp,-16
    80008578:	00813423          	sd	s0,8(sp)
    8000857c:	01010413          	addi	s0,sp,16
    80008580:	100007b7          	lui	a5,0x10000
    80008584:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008588:	f8000713          	li	a4,-128
    8000858c:	00e781a3          	sb	a4,3(a5)
    80008590:	00300713          	li	a4,3
    80008594:	00e78023          	sb	a4,0(a5)
    80008598:	000780a3          	sb	zero,1(a5)
    8000859c:	00e781a3          	sb	a4,3(a5)
    800085a0:	00700693          	li	a3,7
    800085a4:	00d78123          	sb	a3,2(a5)
    800085a8:	00e780a3          	sb	a4,1(a5)
    800085ac:	00813403          	ld	s0,8(sp)
    800085b0:	01010113          	addi	sp,sp,16
    800085b4:	00008067          	ret

00000000800085b8 <uartputc>:
    800085b8:	00004797          	auipc	a5,0x4
    800085bc:	6d07a783          	lw	a5,1744(a5) # 8000cc88 <panicked>
    800085c0:	00078463          	beqz	a5,800085c8 <uartputc+0x10>
    800085c4:	0000006f          	j	800085c4 <uartputc+0xc>
    800085c8:	fd010113          	addi	sp,sp,-48
    800085cc:	02813023          	sd	s0,32(sp)
    800085d0:	00913c23          	sd	s1,24(sp)
    800085d4:	01213823          	sd	s2,16(sp)
    800085d8:	01313423          	sd	s3,8(sp)
    800085dc:	02113423          	sd	ra,40(sp)
    800085e0:	03010413          	addi	s0,sp,48
    800085e4:	00004917          	auipc	s2,0x4
    800085e8:	6ac90913          	addi	s2,s2,1708 # 8000cc90 <uart_tx_r>
    800085ec:	00093783          	ld	a5,0(s2)
    800085f0:	00004497          	auipc	s1,0x4
    800085f4:	6a848493          	addi	s1,s1,1704 # 8000cc98 <uart_tx_w>
    800085f8:	0004b703          	ld	a4,0(s1)
    800085fc:	02078693          	addi	a3,a5,32
    80008600:	00050993          	mv	s3,a0
    80008604:	02e69c63          	bne	a3,a4,8000863c <uartputc+0x84>
    80008608:	00001097          	auipc	ra,0x1
    8000860c:	834080e7          	jalr	-1996(ra) # 80008e3c <push_on>
    80008610:	00093783          	ld	a5,0(s2)
    80008614:	0004b703          	ld	a4,0(s1)
    80008618:	02078793          	addi	a5,a5,32
    8000861c:	00e79463          	bne	a5,a4,80008624 <uartputc+0x6c>
    80008620:	0000006f          	j	80008620 <uartputc+0x68>
    80008624:	00001097          	auipc	ra,0x1
    80008628:	88c080e7          	jalr	-1908(ra) # 80008eb0 <pop_on>
    8000862c:	00093783          	ld	a5,0(s2)
    80008630:	0004b703          	ld	a4,0(s1)
    80008634:	02078693          	addi	a3,a5,32
    80008638:	fce688e3          	beq	a3,a4,80008608 <uartputc+0x50>
    8000863c:	01f77693          	andi	a3,a4,31
    80008640:	00006597          	auipc	a1,0x6
    80008644:	98058593          	addi	a1,a1,-1664 # 8000dfc0 <uart_tx_buf>
    80008648:	00d586b3          	add	a3,a1,a3
    8000864c:	00170713          	addi	a4,a4,1
    80008650:	01368023          	sb	s3,0(a3)
    80008654:	00e4b023          	sd	a4,0(s1)
    80008658:	10000637          	lui	a2,0x10000
    8000865c:	02f71063          	bne	a4,a5,8000867c <uartputc+0xc4>
    80008660:	0340006f          	j	80008694 <uartputc+0xdc>
    80008664:	00074703          	lbu	a4,0(a4)
    80008668:	00f93023          	sd	a5,0(s2)
    8000866c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008670:	00093783          	ld	a5,0(s2)
    80008674:	0004b703          	ld	a4,0(s1)
    80008678:	00f70e63          	beq	a4,a5,80008694 <uartputc+0xdc>
    8000867c:	00564683          	lbu	a3,5(a2)
    80008680:	01f7f713          	andi	a4,a5,31
    80008684:	00e58733          	add	a4,a1,a4
    80008688:	0206f693          	andi	a3,a3,32
    8000868c:	00178793          	addi	a5,a5,1
    80008690:	fc069ae3          	bnez	a3,80008664 <uartputc+0xac>
    80008694:	02813083          	ld	ra,40(sp)
    80008698:	02013403          	ld	s0,32(sp)
    8000869c:	01813483          	ld	s1,24(sp)
    800086a0:	01013903          	ld	s2,16(sp)
    800086a4:	00813983          	ld	s3,8(sp)
    800086a8:	03010113          	addi	sp,sp,48
    800086ac:	00008067          	ret

00000000800086b0 <uartputc_sync>:
    800086b0:	ff010113          	addi	sp,sp,-16
    800086b4:	00813423          	sd	s0,8(sp)
    800086b8:	01010413          	addi	s0,sp,16
    800086bc:	00004717          	auipc	a4,0x4
    800086c0:	5cc72703          	lw	a4,1484(a4) # 8000cc88 <panicked>
    800086c4:	02071663          	bnez	a4,800086f0 <uartputc_sync+0x40>
    800086c8:	00050793          	mv	a5,a0
    800086cc:	100006b7          	lui	a3,0x10000
    800086d0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800086d4:	02077713          	andi	a4,a4,32
    800086d8:	fe070ce3          	beqz	a4,800086d0 <uartputc_sync+0x20>
    800086dc:	0ff7f793          	andi	a5,a5,255
    800086e0:	00f68023          	sb	a5,0(a3)
    800086e4:	00813403          	ld	s0,8(sp)
    800086e8:	01010113          	addi	sp,sp,16
    800086ec:	00008067          	ret
    800086f0:	0000006f          	j	800086f0 <uartputc_sync+0x40>

00000000800086f4 <uartstart>:
    800086f4:	ff010113          	addi	sp,sp,-16
    800086f8:	00813423          	sd	s0,8(sp)
    800086fc:	01010413          	addi	s0,sp,16
    80008700:	00004617          	auipc	a2,0x4
    80008704:	59060613          	addi	a2,a2,1424 # 8000cc90 <uart_tx_r>
    80008708:	00004517          	auipc	a0,0x4
    8000870c:	59050513          	addi	a0,a0,1424 # 8000cc98 <uart_tx_w>
    80008710:	00063783          	ld	a5,0(a2)
    80008714:	00053703          	ld	a4,0(a0)
    80008718:	04f70263          	beq	a4,a5,8000875c <uartstart+0x68>
    8000871c:	100005b7          	lui	a1,0x10000
    80008720:	00006817          	auipc	a6,0x6
    80008724:	8a080813          	addi	a6,a6,-1888 # 8000dfc0 <uart_tx_buf>
    80008728:	01c0006f          	j	80008744 <uartstart+0x50>
    8000872c:	0006c703          	lbu	a4,0(a3)
    80008730:	00f63023          	sd	a5,0(a2)
    80008734:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008738:	00063783          	ld	a5,0(a2)
    8000873c:	00053703          	ld	a4,0(a0)
    80008740:	00f70e63          	beq	a4,a5,8000875c <uartstart+0x68>
    80008744:	01f7f713          	andi	a4,a5,31
    80008748:	00e806b3          	add	a3,a6,a4
    8000874c:	0055c703          	lbu	a4,5(a1)
    80008750:	00178793          	addi	a5,a5,1
    80008754:	02077713          	andi	a4,a4,32
    80008758:	fc071ae3          	bnez	a4,8000872c <uartstart+0x38>
    8000875c:	00813403          	ld	s0,8(sp)
    80008760:	01010113          	addi	sp,sp,16
    80008764:	00008067          	ret

0000000080008768 <uartgetc>:
    80008768:	ff010113          	addi	sp,sp,-16
    8000876c:	00813423          	sd	s0,8(sp)
    80008770:	01010413          	addi	s0,sp,16
    80008774:	10000737          	lui	a4,0x10000
    80008778:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000877c:	0017f793          	andi	a5,a5,1
    80008780:	00078c63          	beqz	a5,80008798 <uartgetc+0x30>
    80008784:	00074503          	lbu	a0,0(a4)
    80008788:	0ff57513          	andi	a0,a0,255
    8000878c:	00813403          	ld	s0,8(sp)
    80008790:	01010113          	addi	sp,sp,16
    80008794:	00008067          	ret
    80008798:	fff00513          	li	a0,-1
    8000879c:	ff1ff06f          	j	8000878c <uartgetc+0x24>

00000000800087a0 <uartintr>:
    800087a0:	100007b7          	lui	a5,0x10000
    800087a4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800087a8:	0017f793          	andi	a5,a5,1
    800087ac:	0a078463          	beqz	a5,80008854 <uartintr+0xb4>
    800087b0:	fe010113          	addi	sp,sp,-32
    800087b4:	00813823          	sd	s0,16(sp)
    800087b8:	00913423          	sd	s1,8(sp)
    800087bc:	00113c23          	sd	ra,24(sp)
    800087c0:	02010413          	addi	s0,sp,32
    800087c4:	100004b7          	lui	s1,0x10000
    800087c8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800087cc:	0ff57513          	andi	a0,a0,255
    800087d0:	fffff097          	auipc	ra,0xfffff
    800087d4:	534080e7          	jalr	1332(ra) # 80007d04 <consoleintr>
    800087d8:	0054c783          	lbu	a5,5(s1)
    800087dc:	0017f793          	andi	a5,a5,1
    800087e0:	fe0794e3          	bnez	a5,800087c8 <uartintr+0x28>
    800087e4:	00004617          	auipc	a2,0x4
    800087e8:	4ac60613          	addi	a2,a2,1196 # 8000cc90 <uart_tx_r>
    800087ec:	00004517          	auipc	a0,0x4
    800087f0:	4ac50513          	addi	a0,a0,1196 # 8000cc98 <uart_tx_w>
    800087f4:	00063783          	ld	a5,0(a2)
    800087f8:	00053703          	ld	a4,0(a0)
    800087fc:	04f70263          	beq	a4,a5,80008840 <uartintr+0xa0>
    80008800:	100005b7          	lui	a1,0x10000
    80008804:	00005817          	auipc	a6,0x5
    80008808:	7bc80813          	addi	a6,a6,1980 # 8000dfc0 <uart_tx_buf>
    8000880c:	01c0006f          	j	80008828 <uartintr+0x88>
    80008810:	0006c703          	lbu	a4,0(a3)
    80008814:	00f63023          	sd	a5,0(a2)
    80008818:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000881c:	00063783          	ld	a5,0(a2)
    80008820:	00053703          	ld	a4,0(a0)
    80008824:	00f70e63          	beq	a4,a5,80008840 <uartintr+0xa0>
    80008828:	01f7f713          	andi	a4,a5,31
    8000882c:	00e806b3          	add	a3,a6,a4
    80008830:	0055c703          	lbu	a4,5(a1)
    80008834:	00178793          	addi	a5,a5,1
    80008838:	02077713          	andi	a4,a4,32
    8000883c:	fc071ae3          	bnez	a4,80008810 <uartintr+0x70>
    80008840:	01813083          	ld	ra,24(sp)
    80008844:	01013403          	ld	s0,16(sp)
    80008848:	00813483          	ld	s1,8(sp)
    8000884c:	02010113          	addi	sp,sp,32
    80008850:	00008067          	ret
    80008854:	00004617          	auipc	a2,0x4
    80008858:	43c60613          	addi	a2,a2,1084 # 8000cc90 <uart_tx_r>
    8000885c:	00004517          	auipc	a0,0x4
    80008860:	43c50513          	addi	a0,a0,1084 # 8000cc98 <uart_tx_w>
    80008864:	00063783          	ld	a5,0(a2)
    80008868:	00053703          	ld	a4,0(a0)
    8000886c:	04f70263          	beq	a4,a5,800088b0 <uartintr+0x110>
    80008870:	100005b7          	lui	a1,0x10000
    80008874:	00005817          	auipc	a6,0x5
    80008878:	74c80813          	addi	a6,a6,1868 # 8000dfc0 <uart_tx_buf>
    8000887c:	01c0006f          	j	80008898 <uartintr+0xf8>
    80008880:	0006c703          	lbu	a4,0(a3)
    80008884:	00f63023          	sd	a5,0(a2)
    80008888:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000888c:	00063783          	ld	a5,0(a2)
    80008890:	00053703          	ld	a4,0(a0)
    80008894:	02f70063          	beq	a4,a5,800088b4 <uartintr+0x114>
    80008898:	01f7f713          	andi	a4,a5,31
    8000889c:	00e806b3          	add	a3,a6,a4
    800088a0:	0055c703          	lbu	a4,5(a1)
    800088a4:	00178793          	addi	a5,a5,1
    800088a8:	02077713          	andi	a4,a4,32
    800088ac:	fc071ae3          	bnez	a4,80008880 <uartintr+0xe0>
    800088b0:	00008067          	ret
    800088b4:	00008067          	ret

00000000800088b8 <kinit>:
    800088b8:	fc010113          	addi	sp,sp,-64
    800088bc:	02913423          	sd	s1,40(sp)
    800088c0:	fffff7b7          	lui	a5,0xfffff
    800088c4:	00006497          	auipc	s1,0x6
    800088c8:	71b48493          	addi	s1,s1,1819 # 8000efdf <end+0xfff>
    800088cc:	02813823          	sd	s0,48(sp)
    800088d0:	01313c23          	sd	s3,24(sp)
    800088d4:	00f4f4b3          	and	s1,s1,a5
    800088d8:	02113c23          	sd	ra,56(sp)
    800088dc:	03213023          	sd	s2,32(sp)
    800088e0:	01413823          	sd	s4,16(sp)
    800088e4:	01513423          	sd	s5,8(sp)
    800088e8:	04010413          	addi	s0,sp,64
    800088ec:	000017b7          	lui	a5,0x1
    800088f0:	01100993          	li	s3,17
    800088f4:	00f487b3          	add	a5,s1,a5
    800088f8:	01b99993          	slli	s3,s3,0x1b
    800088fc:	06f9e063          	bltu	s3,a5,8000895c <kinit+0xa4>
    80008900:	00005a97          	auipc	s5,0x5
    80008904:	6e0a8a93          	addi	s5,s5,1760 # 8000dfe0 <end>
    80008908:	0754ec63          	bltu	s1,s5,80008980 <kinit+0xc8>
    8000890c:	0734fa63          	bgeu	s1,s3,80008980 <kinit+0xc8>
    80008910:	00088a37          	lui	s4,0x88
    80008914:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008918:	00004917          	auipc	s2,0x4
    8000891c:	38890913          	addi	s2,s2,904 # 8000cca0 <kmem>
    80008920:	00ca1a13          	slli	s4,s4,0xc
    80008924:	0140006f          	j	80008938 <kinit+0x80>
    80008928:	000017b7          	lui	a5,0x1
    8000892c:	00f484b3          	add	s1,s1,a5
    80008930:	0554e863          	bltu	s1,s5,80008980 <kinit+0xc8>
    80008934:	0534f663          	bgeu	s1,s3,80008980 <kinit+0xc8>
    80008938:	00001637          	lui	a2,0x1
    8000893c:	00100593          	li	a1,1
    80008940:	00048513          	mv	a0,s1
    80008944:	00000097          	auipc	ra,0x0
    80008948:	5e4080e7          	jalr	1508(ra) # 80008f28 <__memset>
    8000894c:	00093783          	ld	a5,0(s2)
    80008950:	00f4b023          	sd	a5,0(s1)
    80008954:	00993023          	sd	s1,0(s2)
    80008958:	fd4498e3          	bne	s1,s4,80008928 <kinit+0x70>
    8000895c:	03813083          	ld	ra,56(sp)
    80008960:	03013403          	ld	s0,48(sp)
    80008964:	02813483          	ld	s1,40(sp)
    80008968:	02013903          	ld	s2,32(sp)
    8000896c:	01813983          	ld	s3,24(sp)
    80008970:	01013a03          	ld	s4,16(sp)
    80008974:	00813a83          	ld	s5,8(sp)
    80008978:	04010113          	addi	sp,sp,64
    8000897c:	00008067          	ret
    80008980:	00002517          	auipc	a0,0x2
    80008984:	d2050513          	addi	a0,a0,-736 # 8000a6a0 <digits+0x18>
    80008988:	fffff097          	auipc	ra,0xfffff
    8000898c:	4b4080e7          	jalr	1204(ra) # 80007e3c <panic>

0000000080008990 <freerange>:
    80008990:	fc010113          	addi	sp,sp,-64
    80008994:	000017b7          	lui	a5,0x1
    80008998:	02913423          	sd	s1,40(sp)
    8000899c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800089a0:	009504b3          	add	s1,a0,s1
    800089a4:	fffff537          	lui	a0,0xfffff
    800089a8:	02813823          	sd	s0,48(sp)
    800089ac:	02113c23          	sd	ra,56(sp)
    800089b0:	03213023          	sd	s2,32(sp)
    800089b4:	01313c23          	sd	s3,24(sp)
    800089b8:	01413823          	sd	s4,16(sp)
    800089bc:	01513423          	sd	s5,8(sp)
    800089c0:	01613023          	sd	s6,0(sp)
    800089c4:	04010413          	addi	s0,sp,64
    800089c8:	00a4f4b3          	and	s1,s1,a0
    800089cc:	00f487b3          	add	a5,s1,a5
    800089d0:	06f5e463          	bltu	a1,a5,80008a38 <freerange+0xa8>
    800089d4:	00005a97          	auipc	s5,0x5
    800089d8:	60ca8a93          	addi	s5,s5,1548 # 8000dfe0 <end>
    800089dc:	0954e263          	bltu	s1,s5,80008a60 <freerange+0xd0>
    800089e0:	01100993          	li	s3,17
    800089e4:	01b99993          	slli	s3,s3,0x1b
    800089e8:	0734fc63          	bgeu	s1,s3,80008a60 <freerange+0xd0>
    800089ec:	00058a13          	mv	s4,a1
    800089f0:	00004917          	auipc	s2,0x4
    800089f4:	2b090913          	addi	s2,s2,688 # 8000cca0 <kmem>
    800089f8:	00002b37          	lui	s6,0x2
    800089fc:	0140006f          	j	80008a10 <freerange+0x80>
    80008a00:	000017b7          	lui	a5,0x1
    80008a04:	00f484b3          	add	s1,s1,a5
    80008a08:	0554ec63          	bltu	s1,s5,80008a60 <freerange+0xd0>
    80008a0c:	0534fa63          	bgeu	s1,s3,80008a60 <freerange+0xd0>
    80008a10:	00001637          	lui	a2,0x1
    80008a14:	00100593          	li	a1,1
    80008a18:	00048513          	mv	a0,s1
    80008a1c:	00000097          	auipc	ra,0x0
    80008a20:	50c080e7          	jalr	1292(ra) # 80008f28 <__memset>
    80008a24:	00093703          	ld	a4,0(s2)
    80008a28:	016487b3          	add	a5,s1,s6
    80008a2c:	00e4b023          	sd	a4,0(s1)
    80008a30:	00993023          	sd	s1,0(s2)
    80008a34:	fcfa76e3          	bgeu	s4,a5,80008a00 <freerange+0x70>
    80008a38:	03813083          	ld	ra,56(sp)
    80008a3c:	03013403          	ld	s0,48(sp)
    80008a40:	02813483          	ld	s1,40(sp)
    80008a44:	02013903          	ld	s2,32(sp)
    80008a48:	01813983          	ld	s3,24(sp)
    80008a4c:	01013a03          	ld	s4,16(sp)
    80008a50:	00813a83          	ld	s5,8(sp)
    80008a54:	00013b03          	ld	s6,0(sp)
    80008a58:	04010113          	addi	sp,sp,64
    80008a5c:	00008067          	ret
    80008a60:	00002517          	auipc	a0,0x2
    80008a64:	c4050513          	addi	a0,a0,-960 # 8000a6a0 <digits+0x18>
    80008a68:	fffff097          	auipc	ra,0xfffff
    80008a6c:	3d4080e7          	jalr	980(ra) # 80007e3c <panic>

0000000080008a70 <kfree>:
    80008a70:	fe010113          	addi	sp,sp,-32
    80008a74:	00813823          	sd	s0,16(sp)
    80008a78:	00113c23          	sd	ra,24(sp)
    80008a7c:	00913423          	sd	s1,8(sp)
    80008a80:	02010413          	addi	s0,sp,32
    80008a84:	03451793          	slli	a5,a0,0x34
    80008a88:	04079c63          	bnez	a5,80008ae0 <kfree+0x70>
    80008a8c:	00005797          	auipc	a5,0x5
    80008a90:	55478793          	addi	a5,a5,1364 # 8000dfe0 <end>
    80008a94:	00050493          	mv	s1,a0
    80008a98:	04f56463          	bltu	a0,a5,80008ae0 <kfree+0x70>
    80008a9c:	01100793          	li	a5,17
    80008aa0:	01b79793          	slli	a5,a5,0x1b
    80008aa4:	02f57e63          	bgeu	a0,a5,80008ae0 <kfree+0x70>
    80008aa8:	00001637          	lui	a2,0x1
    80008aac:	00100593          	li	a1,1
    80008ab0:	00000097          	auipc	ra,0x0
    80008ab4:	478080e7          	jalr	1144(ra) # 80008f28 <__memset>
    80008ab8:	00004797          	auipc	a5,0x4
    80008abc:	1e878793          	addi	a5,a5,488 # 8000cca0 <kmem>
    80008ac0:	0007b703          	ld	a4,0(a5)
    80008ac4:	01813083          	ld	ra,24(sp)
    80008ac8:	01013403          	ld	s0,16(sp)
    80008acc:	00e4b023          	sd	a4,0(s1)
    80008ad0:	0097b023          	sd	s1,0(a5)
    80008ad4:	00813483          	ld	s1,8(sp)
    80008ad8:	02010113          	addi	sp,sp,32
    80008adc:	00008067          	ret
    80008ae0:	00002517          	auipc	a0,0x2
    80008ae4:	bc050513          	addi	a0,a0,-1088 # 8000a6a0 <digits+0x18>
    80008ae8:	fffff097          	auipc	ra,0xfffff
    80008aec:	354080e7          	jalr	852(ra) # 80007e3c <panic>

0000000080008af0 <kalloc>:
    80008af0:	fe010113          	addi	sp,sp,-32
    80008af4:	00813823          	sd	s0,16(sp)
    80008af8:	00913423          	sd	s1,8(sp)
    80008afc:	00113c23          	sd	ra,24(sp)
    80008b00:	02010413          	addi	s0,sp,32
    80008b04:	00004797          	auipc	a5,0x4
    80008b08:	19c78793          	addi	a5,a5,412 # 8000cca0 <kmem>
    80008b0c:	0007b483          	ld	s1,0(a5)
    80008b10:	02048063          	beqz	s1,80008b30 <kalloc+0x40>
    80008b14:	0004b703          	ld	a4,0(s1)
    80008b18:	00001637          	lui	a2,0x1
    80008b1c:	00500593          	li	a1,5
    80008b20:	00048513          	mv	a0,s1
    80008b24:	00e7b023          	sd	a4,0(a5)
    80008b28:	00000097          	auipc	ra,0x0
    80008b2c:	400080e7          	jalr	1024(ra) # 80008f28 <__memset>
    80008b30:	01813083          	ld	ra,24(sp)
    80008b34:	01013403          	ld	s0,16(sp)
    80008b38:	00048513          	mv	a0,s1
    80008b3c:	00813483          	ld	s1,8(sp)
    80008b40:	02010113          	addi	sp,sp,32
    80008b44:	00008067          	ret

0000000080008b48 <initlock>:
    80008b48:	ff010113          	addi	sp,sp,-16
    80008b4c:	00813423          	sd	s0,8(sp)
    80008b50:	01010413          	addi	s0,sp,16
    80008b54:	00813403          	ld	s0,8(sp)
    80008b58:	00b53423          	sd	a1,8(a0)
    80008b5c:	00052023          	sw	zero,0(a0)
    80008b60:	00053823          	sd	zero,16(a0)
    80008b64:	01010113          	addi	sp,sp,16
    80008b68:	00008067          	ret

0000000080008b6c <acquire>:
    80008b6c:	fe010113          	addi	sp,sp,-32
    80008b70:	00813823          	sd	s0,16(sp)
    80008b74:	00913423          	sd	s1,8(sp)
    80008b78:	00113c23          	sd	ra,24(sp)
    80008b7c:	01213023          	sd	s2,0(sp)
    80008b80:	02010413          	addi	s0,sp,32
    80008b84:	00050493          	mv	s1,a0
    80008b88:	10002973          	csrr	s2,sstatus
    80008b8c:	100027f3          	csrr	a5,sstatus
    80008b90:	ffd7f793          	andi	a5,a5,-3
    80008b94:	10079073          	csrw	sstatus,a5
    80008b98:	fffff097          	auipc	ra,0xfffff
    80008b9c:	8ec080e7          	jalr	-1812(ra) # 80007484 <mycpu>
    80008ba0:	07852783          	lw	a5,120(a0)
    80008ba4:	06078e63          	beqz	a5,80008c20 <acquire+0xb4>
    80008ba8:	fffff097          	auipc	ra,0xfffff
    80008bac:	8dc080e7          	jalr	-1828(ra) # 80007484 <mycpu>
    80008bb0:	07852783          	lw	a5,120(a0)
    80008bb4:	0004a703          	lw	a4,0(s1)
    80008bb8:	0017879b          	addiw	a5,a5,1
    80008bbc:	06f52c23          	sw	a5,120(a0)
    80008bc0:	04071063          	bnez	a4,80008c00 <acquire+0x94>
    80008bc4:	00100713          	li	a4,1
    80008bc8:	00070793          	mv	a5,a4
    80008bcc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008bd0:	0007879b          	sext.w	a5,a5
    80008bd4:	fe079ae3          	bnez	a5,80008bc8 <acquire+0x5c>
    80008bd8:	0ff0000f          	fence
    80008bdc:	fffff097          	auipc	ra,0xfffff
    80008be0:	8a8080e7          	jalr	-1880(ra) # 80007484 <mycpu>
    80008be4:	01813083          	ld	ra,24(sp)
    80008be8:	01013403          	ld	s0,16(sp)
    80008bec:	00a4b823          	sd	a0,16(s1)
    80008bf0:	00013903          	ld	s2,0(sp)
    80008bf4:	00813483          	ld	s1,8(sp)
    80008bf8:	02010113          	addi	sp,sp,32
    80008bfc:	00008067          	ret
    80008c00:	0104b903          	ld	s2,16(s1)
    80008c04:	fffff097          	auipc	ra,0xfffff
    80008c08:	880080e7          	jalr	-1920(ra) # 80007484 <mycpu>
    80008c0c:	faa91ce3          	bne	s2,a0,80008bc4 <acquire+0x58>
    80008c10:	00002517          	auipc	a0,0x2
    80008c14:	a9850513          	addi	a0,a0,-1384 # 8000a6a8 <digits+0x20>
    80008c18:	fffff097          	auipc	ra,0xfffff
    80008c1c:	224080e7          	jalr	548(ra) # 80007e3c <panic>
    80008c20:	00195913          	srli	s2,s2,0x1
    80008c24:	fffff097          	auipc	ra,0xfffff
    80008c28:	860080e7          	jalr	-1952(ra) # 80007484 <mycpu>
    80008c2c:	00197913          	andi	s2,s2,1
    80008c30:	07252e23          	sw	s2,124(a0)
    80008c34:	f75ff06f          	j	80008ba8 <acquire+0x3c>

0000000080008c38 <release>:
    80008c38:	fe010113          	addi	sp,sp,-32
    80008c3c:	00813823          	sd	s0,16(sp)
    80008c40:	00113c23          	sd	ra,24(sp)
    80008c44:	00913423          	sd	s1,8(sp)
    80008c48:	01213023          	sd	s2,0(sp)
    80008c4c:	02010413          	addi	s0,sp,32
    80008c50:	00052783          	lw	a5,0(a0)
    80008c54:	00079a63          	bnez	a5,80008c68 <release+0x30>
    80008c58:	00002517          	auipc	a0,0x2
    80008c5c:	a5850513          	addi	a0,a0,-1448 # 8000a6b0 <digits+0x28>
    80008c60:	fffff097          	auipc	ra,0xfffff
    80008c64:	1dc080e7          	jalr	476(ra) # 80007e3c <panic>
    80008c68:	01053903          	ld	s2,16(a0)
    80008c6c:	00050493          	mv	s1,a0
    80008c70:	fffff097          	auipc	ra,0xfffff
    80008c74:	814080e7          	jalr	-2028(ra) # 80007484 <mycpu>
    80008c78:	fea910e3          	bne	s2,a0,80008c58 <release+0x20>
    80008c7c:	0004b823          	sd	zero,16(s1)
    80008c80:	0ff0000f          	fence
    80008c84:	0f50000f          	fence	iorw,ow
    80008c88:	0804a02f          	amoswap.w	zero,zero,(s1)
    80008c8c:	ffffe097          	auipc	ra,0xffffe
    80008c90:	7f8080e7          	jalr	2040(ra) # 80007484 <mycpu>
    80008c94:	100027f3          	csrr	a5,sstatus
    80008c98:	0027f793          	andi	a5,a5,2
    80008c9c:	04079a63          	bnez	a5,80008cf0 <release+0xb8>
    80008ca0:	07852783          	lw	a5,120(a0)
    80008ca4:	02f05e63          	blez	a5,80008ce0 <release+0xa8>
    80008ca8:	fff7871b          	addiw	a4,a5,-1
    80008cac:	06e52c23          	sw	a4,120(a0)
    80008cb0:	00071c63          	bnez	a4,80008cc8 <release+0x90>
    80008cb4:	07c52783          	lw	a5,124(a0)
    80008cb8:	00078863          	beqz	a5,80008cc8 <release+0x90>
    80008cbc:	100027f3          	csrr	a5,sstatus
    80008cc0:	0027e793          	ori	a5,a5,2
    80008cc4:	10079073          	csrw	sstatus,a5
    80008cc8:	01813083          	ld	ra,24(sp)
    80008ccc:	01013403          	ld	s0,16(sp)
    80008cd0:	00813483          	ld	s1,8(sp)
    80008cd4:	00013903          	ld	s2,0(sp)
    80008cd8:	02010113          	addi	sp,sp,32
    80008cdc:	00008067          	ret
    80008ce0:	00002517          	auipc	a0,0x2
    80008ce4:	9f050513          	addi	a0,a0,-1552 # 8000a6d0 <digits+0x48>
    80008ce8:	fffff097          	auipc	ra,0xfffff
    80008cec:	154080e7          	jalr	340(ra) # 80007e3c <panic>
    80008cf0:	00002517          	auipc	a0,0x2
    80008cf4:	9c850513          	addi	a0,a0,-1592 # 8000a6b8 <digits+0x30>
    80008cf8:	fffff097          	auipc	ra,0xfffff
    80008cfc:	144080e7          	jalr	324(ra) # 80007e3c <panic>

0000000080008d00 <holding>:
    80008d00:	00052783          	lw	a5,0(a0)
    80008d04:	00079663          	bnez	a5,80008d10 <holding+0x10>
    80008d08:	00000513          	li	a0,0
    80008d0c:	00008067          	ret
    80008d10:	fe010113          	addi	sp,sp,-32
    80008d14:	00813823          	sd	s0,16(sp)
    80008d18:	00913423          	sd	s1,8(sp)
    80008d1c:	00113c23          	sd	ra,24(sp)
    80008d20:	02010413          	addi	s0,sp,32
    80008d24:	01053483          	ld	s1,16(a0)
    80008d28:	ffffe097          	auipc	ra,0xffffe
    80008d2c:	75c080e7          	jalr	1884(ra) # 80007484 <mycpu>
    80008d30:	01813083          	ld	ra,24(sp)
    80008d34:	01013403          	ld	s0,16(sp)
    80008d38:	40a48533          	sub	a0,s1,a0
    80008d3c:	00153513          	seqz	a0,a0
    80008d40:	00813483          	ld	s1,8(sp)
    80008d44:	02010113          	addi	sp,sp,32
    80008d48:	00008067          	ret

0000000080008d4c <push_off>:
    80008d4c:	fe010113          	addi	sp,sp,-32
    80008d50:	00813823          	sd	s0,16(sp)
    80008d54:	00113c23          	sd	ra,24(sp)
    80008d58:	00913423          	sd	s1,8(sp)
    80008d5c:	02010413          	addi	s0,sp,32
    80008d60:	100024f3          	csrr	s1,sstatus
    80008d64:	100027f3          	csrr	a5,sstatus
    80008d68:	ffd7f793          	andi	a5,a5,-3
    80008d6c:	10079073          	csrw	sstatus,a5
    80008d70:	ffffe097          	auipc	ra,0xffffe
    80008d74:	714080e7          	jalr	1812(ra) # 80007484 <mycpu>
    80008d78:	07852783          	lw	a5,120(a0)
    80008d7c:	02078663          	beqz	a5,80008da8 <push_off+0x5c>
    80008d80:	ffffe097          	auipc	ra,0xffffe
    80008d84:	704080e7          	jalr	1796(ra) # 80007484 <mycpu>
    80008d88:	07852783          	lw	a5,120(a0)
    80008d8c:	01813083          	ld	ra,24(sp)
    80008d90:	01013403          	ld	s0,16(sp)
    80008d94:	0017879b          	addiw	a5,a5,1
    80008d98:	06f52c23          	sw	a5,120(a0)
    80008d9c:	00813483          	ld	s1,8(sp)
    80008da0:	02010113          	addi	sp,sp,32
    80008da4:	00008067          	ret
    80008da8:	0014d493          	srli	s1,s1,0x1
    80008dac:	ffffe097          	auipc	ra,0xffffe
    80008db0:	6d8080e7          	jalr	1752(ra) # 80007484 <mycpu>
    80008db4:	0014f493          	andi	s1,s1,1
    80008db8:	06952e23          	sw	s1,124(a0)
    80008dbc:	fc5ff06f          	j	80008d80 <push_off+0x34>

0000000080008dc0 <pop_off>:
    80008dc0:	ff010113          	addi	sp,sp,-16
    80008dc4:	00813023          	sd	s0,0(sp)
    80008dc8:	00113423          	sd	ra,8(sp)
    80008dcc:	01010413          	addi	s0,sp,16
    80008dd0:	ffffe097          	auipc	ra,0xffffe
    80008dd4:	6b4080e7          	jalr	1716(ra) # 80007484 <mycpu>
    80008dd8:	100027f3          	csrr	a5,sstatus
    80008ddc:	0027f793          	andi	a5,a5,2
    80008de0:	04079663          	bnez	a5,80008e2c <pop_off+0x6c>
    80008de4:	07852783          	lw	a5,120(a0)
    80008de8:	02f05a63          	blez	a5,80008e1c <pop_off+0x5c>
    80008dec:	fff7871b          	addiw	a4,a5,-1
    80008df0:	06e52c23          	sw	a4,120(a0)
    80008df4:	00071c63          	bnez	a4,80008e0c <pop_off+0x4c>
    80008df8:	07c52783          	lw	a5,124(a0)
    80008dfc:	00078863          	beqz	a5,80008e0c <pop_off+0x4c>
    80008e00:	100027f3          	csrr	a5,sstatus
    80008e04:	0027e793          	ori	a5,a5,2
    80008e08:	10079073          	csrw	sstatus,a5
    80008e0c:	00813083          	ld	ra,8(sp)
    80008e10:	00013403          	ld	s0,0(sp)
    80008e14:	01010113          	addi	sp,sp,16
    80008e18:	00008067          	ret
    80008e1c:	00002517          	auipc	a0,0x2
    80008e20:	8b450513          	addi	a0,a0,-1868 # 8000a6d0 <digits+0x48>
    80008e24:	fffff097          	auipc	ra,0xfffff
    80008e28:	018080e7          	jalr	24(ra) # 80007e3c <panic>
    80008e2c:	00002517          	auipc	a0,0x2
    80008e30:	88c50513          	addi	a0,a0,-1908 # 8000a6b8 <digits+0x30>
    80008e34:	fffff097          	auipc	ra,0xfffff
    80008e38:	008080e7          	jalr	8(ra) # 80007e3c <panic>

0000000080008e3c <push_on>:
    80008e3c:	fe010113          	addi	sp,sp,-32
    80008e40:	00813823          	sd	s0,16(sp)
    80008e44:	00113c23          	sd	ra,24(sp)
    80008e48:	00913423          	sd	s1,8(sp)
    80008e4c:	02010413          	addi	s0,sp,32
    80008e50:	100024f3          	csrr	s1,sstatus
    80008e54:	100027f3          	csrr	a5,sstatus
    80008e58:	0027e793          	ori	a5,a5,2
    80008e5c:	10079073          	csrw	sstatus,a5
    80008e60:	ffffe097          	auipc	ra,0xffffe
    80008e64:	624080e7          	jalr	1572(ra) # 80007484 <mycpu>
    80008e68:	07852783          	lw	a5,120(a0)
    80008e6c:	02078663          	beqz	a5,80008e98 <push_on+0x5c>
    80008e70:	ffffe097          	auipc	ra,0xffffe
    80008e74:	614080e7          	jalr	1556(ra) # 80007484 <mycpu>
    80008e78:	07852783          	lw	a5,120(a0)
    80008e7c:	01813083          	ld	ra,24(sp)
    80008e80:	01013403          	ld	s0,16(sp)
    80008e84:	0017879b          	addiw	a5,a5,1
    80008e88:	06f52c23          	sw	a5,120(a0)
    80008e8c:	00813483          	ld	s1,8(sp)
    80008e90:	02010113          	addi	sp,sp,32
    80008e94:	00008067          	ret
    80008e98:	0014d493          	srli	s1,s1,0x1
    80008e9c:	ffffe097          	auipc	ra,0xffffe
    80008ea0:	5e8080e7          	jalr	1512(ra) # 80007484 <mycpu>
    80008ea4:	0014f493          	andi	s1,s1,1
    80008ea8:	06952e23          	sw	s1,124(a0)
    80008eac:	fc5ff06f          	j	80008e70 <push_on+0x34>

0000000080008eb0 <pop_on>:
    80008eb0:	ff010113          	addi	sp,sp,-16
    80008eb4:	00813023          	sd	s0,0(sp)
    80008eb8:	00113423          	sd	ra,8(sp)
    80008ebc:	01010413          	addi	s0,sp,16
    80008ec0:	ffffe097          	auipc	ra,0xffffe
    80008ec4:	5c4080e7          	jalr	1476(ra) # 80007484 <mycpu>
    80008ec8:	100027f3          	csrr	a5,sstatus
    80008ecc:	0027f793          	andi	a5,a5,2
    80008ed0:	04078463          	beqz	a5,80008f18 <pop_on+0x68>
    80008ed4:	07852783          	lw	a5,120(a0)
    80008ed8:	02f05863          	blez	a5,80008f08 <pop_on+0x58>
    80008edc:	fff7879b          	addiw	a5,a5,-1
    80008ee0:	06f52c23          	sw	a5,120(a0)
    80008ee4:	07853783          	ld	a5,120(a0)
    80008ee8:	00079863          	bnez	a5,80008ef8 <pop_on+0x48>
    80008eec:	100027f3          	csrr	a5,sstatus
    80008ef0:	ffd7f793          	andi	a5,a5,-3
    80008ef4:	10079073          	csrw	sstatus,a5
    80008ef8:	00813083          	ld	ra,8(sp)
    80008efc:	00013403          	ld	s0,0(sp)
    80008f00:	01010113          	addi	sp,sp,16
    80008f04:	00008067          	ret
    80008f08:	00001517          	auipc	a0,0x1
    80008f0c:	7f050513          	addi	a0,a0,2032 # 8000a6f8 <digits+0x70>
    80008f10:	fffff097          	auipc	ra,0xfffff
    80008f14:	f2c080e7          	jalr	-212(ra) # 80007e3c <panic>
    80008f18:	00001517          	auipc	a0,0x1
    80008f1c:	7c050513          	addi	a0,a0,1984 # 8000a6d8 <digits+0x50>
    80008f20:	fffff097          	auipc	ra,0xfffff
    80008f24:	f1c080e7          	jalr	-228(ra) # 80007e3c <panic>

0000000080008f28 <__memset>:
    80008f28:	ff010113          	addi	sp,sp,-16
    80008f2c:	00813423          	sd	s0,8(sp)
    80008f30:	01010413          	addi	s0,sp,16
    80008f34:	1a060e63          	beqz	a2,800090f0 <__memset+0x1c8>
    80008f38:	40a007b3          	neg	a5,a0
    80008f3c:	0077f793          	andi	a5,a5,7
    80008f40:	00778693          	addi	a3,a5,7
    80008f44:	00b00813          	li	a6,11
    80008f48:	0ff5f593          	andi	a1,a1,255
    80008f4c:	fff6071b          	addiw	a4,a2,-1
    80008f50:	1b06e663          	bltu	a3,a6,800090fc <__memset+0x1d4>
    80008f54:	1cd76463          	bltu	a4,a3,8000911c <__memset+0x1f4>
    80008f58:	1a078e63          	beqz	a5,80009114 <__memset+0x1ec>
    80008f5c:	00b50023          	sb	a1,0(a0)
    80008f60:	00100713          	li	a4,1
    80008f64:	1ae78463          	beq	a5,a4,8000910c <__memset+0x1e4>
    80008f68:	00b500a3          	sb	a1,1(a0)
    80008f6c:	00200713          	li	a4,2
    80008f70:	1ae78a63          	beq	a5,a4,80009124 <__memset+0x1fc>
    80008f74:	00b50123          	sb	a1,2(a0)
    80008f78:	00300713          	li	a4,3
    80008f7c:	18e78463          	beq	a5,a4,80009104 <__memset+0x1dc>
    80008f80:	00b501a3          	sb	a1,3(a0)
    80008f84:	00400713          	li	a4,4
    80008f88:	1ae78263          	beq	a5,a4,8000912c <__memset+0x204>
    80008f8c:	00b50223          	sb	a1,4(a0)
    80008f90:	00500713          	li	a4,5
    80008f94:	1ae78063          	beq	a5,a4,80009134 <__memset+0x20c>
    80008f98:	00b502a3          	sb	a1,5(a0)
    80008f9c:	00700713          	li	a4,7
    80008fa0:	18e79e63          	bne	a5,a4,8000913c <__memset+0x214>
    80008fa4:	00b50323          	sb	a1,6(a0)
    80008fa8:	00700e93          	li	t4,7
    80008fac:	00859713          	slli	a4,a1,0x8
    80008fb0:	00e5e733          	or	a4,a1,a4
    80008fb4:	01059e13          	slli	t3,a1,0x10
    80008fb8:	01c76e33          	or	t3,a4,t3
    80008fbc:	01859313          	slli	t1,a1,0x18
    80008fc0:	006e6333          	or	t1,t3,t1
    80008fc4:	02059893          	slli	a7,a1,0x20
    80008fc8:	40f60e3b          	subw	t3,a2,a5
    80008fcc:	011368b3          	or	a7,t1,a7
    80008fd0:	02859813          	slli	a6,a1,0x28
    80008fd4:	0108e833          	or	a6,a7,a6
    80008fd8:	03059693          	slli	a3,a1,0x30
    80008fdc:	003e589b          	srliw	a7,t3,0x3
    80008fe0:	00d866b3          	or	a3,a6,a3
    80008fe4:	03859713          	slli	a4,a1,0x38
    80008fe8:	00389813          	slli	a6,a7,0x3
    80008fec:	00f507b3          	add	a5,a0,a5
    80008ff0:	00e6e733          	or	a4,a3,a4
    80008ff4:	000e089b          	sext.w	a7,t3
    80008ff8:	00f806b3          	add	a3,a6,a5
    80008ffc:	00e7b023          	sd	a4,0(a5)
    80009000:	00878793          	addi	a5,a5,8
    80009004:	fed79ce3          	bne	a5,a3,80008ffc <__memset+0xd4>
    80009008:	ff8e7793          	andi	a5,t3,-8
    8000900c:	0007871b          	sext.w	a4,a5
    80009010:	01d787bb          	addw	a5,a5,t4
    80009014:	0ce88e63          	beq	a7,a4,800090f0 <__memset+0x1c8>
    80009018:	00f50733          	add	a4,a0,a5
    8000901c:	00b70023          	sb	a1,0(a4)
    80009020:	0017871b          	addiw	a4,a5,1
    80009024:	0cc77663          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009028:	00e50733          	add	a4,a0,a4
    8000902c:	00b70023          	sb	a1,0(a4)
    80009030:	0027871b          	addiw	a4,a5,2
    80009034:	0ac77e63          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009038:	00e50733          	add	a4,a0,a4
    8000903c:	00b70023          	sb	a1,0(a4)
    80009040:	0037871b          	addiw	a4,a5,3
    80009044:	0ac77663          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009048:	00e50733          	add	a4,a0,a4
    8000904c:	00b70023          	sb	a1,0(a4)
    80009050:	0047871b          	addiw	a4,a5,4
    80009054:	08c77e63          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009058:	00e50733          	add	a4,a0,a4
    8000905c:	00b70023          	sb	a1,0(a4)
    80009060:	0057871b          	addiw	a4,a5,5
    80009064:	08c77663          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009068:	00e50733          	add	a4,a0,a4
    8000906c:	00b70023          	sb	a1,0(a4)
    80009070:	0067871b          	addiw	a4,a5,6
    80009074:	06c77e63          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009078:	00e50733          	add	a4,a0,a4
    8000907c:	00b70023          	sb	a1,0(a4)
    80009080:	0077871b          	addiw	a4,a5,7
    80009084:	06c77663          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009088:	00e50733          	add	a4,a0,a4
    8000908c:	00b70023          	sb	a1,0(a4)
    80009090:	0087871b          	addiw	a4,a5,8
    80009094:	04c77e63          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    80009098:	00e50733          	add	a4,a0,a4
    8000909c:	00b70023          	sb	a1,0(a4)
    800090a0:	0097871b          	addiw	a4,a5,9
    800090a4:	04c77663          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    800090a8:	00e50733          	add	a4,a0,a4
    800090ac:	00b70023          	sb	a1,0(a4)
    800090b0:	00a7871b          	addiw	a4,a5,10
    800090b4:	02c77e63          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    800090b8:	00e50733          	add	a4,a0,a4
    800090bc:	00b70023          	sb	a1,0(a4)
    800090c0:	00b7871b          	addiw	a4,a5,11
    800090c4:	02c77663          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    800090c8:	00e50733          	add	a4,a0,a4
    800090cc:	00b70023          	sb	a1,0(a4)
    800090d0:	00c7871b          	addiw	a4,a5,12
    800090d4:	00c77e63          	bgeu	a4,a2,800090f0 <__memset+0x1c8>
    800090d8:	00e50733          	add	a4,a0,a4
    800090dc:	00b70023          	sb	a1,0(a4)
    800090e0:	00d7879b          	addiw	a5,a5,13
    800090e4:	00c7f663          	bgeu	a5,a2,800090f0 <__memset+0x1c8>
    800090e8:	00f507b3          	add	a5,a0,a5
    800090ec:	00b78023          	sb	a1,0(a5)
    800090f0:	00813403          	ld	s0,8(sp)
    800090f4:	01010113          	addi	sp,sp,16
    800090f8:	00008067          	ret
    800090fc:	00b00693          	li	a3,11
    80009100:	e55ff06f          	j	80008f54 <__memset+0x2c>
    80009104:	00300e93          	li	t4,3
    80009108:	ea5ff06f          	j	80008fac <__memset+0x84>
    8000910c:	00100e93          	li	t4,1
    80009110:	e9dff06f          	j	80008fac <__memset+0x84>
    80009114:	00000e93          	li	t4,0
    80009118:	e95ff06f          	j	80008fac <__memset+0x84>
    8000911c:	00000793          	li	a5,0
    80009120:	ef9ff06f          	j	80009018 <__memset+0xf0>
    80009124:	00200e93          	li	t4,2
    80009128:	e85ff06f          	j	80008fac <__memset+0x84>
    8000912c:	00400e93          	li	t4,4
    80009130:	e7dff06f          	j	80008fac <__memset+0x84>
    80009134:	00500e93          	li	t4,5
    80009138:	e75ff06f          	j	80008fac <__memset+0x84>
    8000913c:	00600e93          	li	t4,6
    80009140:	e6dff06f          	j	80008fac <__memset+0x84>

0000000080009144 <__memmove>:
    80009144:	ff010113          	addi	sp,sp,-16
    80009148:	00813423          	sd	s0,8(sp)
    8000914c:	01010413          	addi	s0,sp,16
    80009150:	0e060863          	beqz	a2,80009240 <__memmove+0xfc>
    80009154:	fff6069b          	addiw	a3,a2,-1
    80009158:	0006881b          	sext.w	a6,a3
    8000915c:	0ea5e863          	bltu	a1,a0,8000924c <__memmove+0x108>
    80009160:	00758713          	addi	a4,a1,7
    80009164:	00a5e7b3          	or	a5,a1,a0
    80009168:	40a70733          	sub	a4,a4,a0
    8000916c:	0077f793          	andi	a5,a5,7
    80009170:	00f73713          	sltiu	a4,a4,15
    80009174:	00174713          	xori	a4,a4,1
    80009178:	0017b793          	seqz	a5,a5
    8000917c:	00e7f7b3          	and	a5,a5,a4
    80009180:	10078863          	beqz	a5,80009290 <__memmove+0x14c>
    80009184:	00900793          	li	a5,9
    80009188:	1107f463          	bgeu	a5,a6,80009290 <__memmove+0x14c>
    8000918c:	0036581b          	srliw	a6,a2,0x3
    80009190:	fff8081b          	addiw	a6,a6,-1
    80009194:	02081813          	slli	a6,a6,0x20
    80009198:	01d85893          	srli	a7,a6,0x1d
    8000919c:	00858813          	addi	a6,a1,8
    800091a0:	00058793          	mv	a5,a1
    800091a4:	00050713          	mv	a4,a0
    800091a8:	01088833          	add	a6,a7,a6
    800091ac:	0007b883          	ld	a7,0(a5)
    800091b0:	00878793          	addi	a5,a5,8
    800091b4:	00870713          	addi	a4,a4,8
    800091b8:	ff173c23          	sd	a7,-8(a4)
    800091bc:	ff0798e3          	bne	a5,a6,800091ac <__memmove+0x68>
    800091c0:	ff867713          	andi	a4,a2,-8
    800091c4:	02071793          	slli	a5,a4,0x20
    800091c8:	0207d793          	srli	a5,a5,0x20
    800091cc:	00f585b3          	add	a1,a1,a5
    800091d0:	40e686bb          	subw	a3,a3,a4
    800091d4:	00f507b3          	add	a5,a0,a5
    800091d8:	06e60463          	beq	a2,a4,80009240 <__memmove+0xfc>
    800091dc:	0005c703          	lbu	a4,0(a1)
    800091e0:	00e78023          	sb	a4,0(a5)
    800091e4:	04068e63          	beqz	a3,80009240 <__memmove+0xfc>
    800091e8:	0015c603          	lbu	a2,1(a1)
    800091ec:	00100713          	li	a4,1
    800091f0:	00c780a3          	sb	a2,1(a5)
    800091f4:	04e68663          	beq	a3,a4,80009240 <__memmove+0xfc>
    800091f8:	0025c603          	lbu	a2,2(a1)
    800091fc:	00200713          	li	a4,2
    80009200:	00c78123          	sb	a2,2(a5)
    80009204:	02e68e63          	beq	a3,a4,80009240 <__memmove+0xfc>
    80009208:	0035c603          	lbu	a2,3(a1)
    8000920c:	00300713          	li	a4,3
    80009210:	00c781a3          	sb	a2,3(a5)
    80009214:	02e68663          	beq	a3,a4,80009240 <__memmove+0xfc>
    80009218:	0045c603          	lbu	a2,4(a1)
    8000921c:	00400713          	li	a4,4
    80009220:	00c78223          	sb	a2,4(a5)
    80009224:	00e68e63          	beq	a3,a4,80009240 <__memmove+0xfc>
    80009228:	0055c603          	lbu	a2,5(a1)
    8000922c:	00500713          	li	a4,5
    80009230:	00c782a3          	sb	a2,5(a5)
    80009234:	00e68663          	beq	a3,a4,80009240 <__memmove+0xfc>
    80009238:	0065c703          	lbu	a4,6(a1)
    8000923c:	00e78323          	sb	a4,6(a5)
    80009240:	00813403          	ld	s0,8(sp)
    80009244:	01010113          	addi	sp,sp,16
    80009248:	00008067          	ret
    8000924c:	02061713          	slli	a4,a2,0x20
    80009250:	02075713          	srli	a4,a4,0x20
    80009254:	00e587b3          	add	a5,a1,a4
    80009258:	f0f574e3          	bgeu	a0,a5,80009160 <__memmove+0x1c>
    8000925c:	02069613          	slli	a2,a3,0x20
    80009260:	02065613          	srli	a2,a2,0x20
    80009264:	fff64613          	not	a2,a2
    80009268:	00e50733          	add	a4,a0,a4
    8000926c:	00c78633          	add	a2,a5,a2
    80009270:	fff7c683          	lbu	a3,-1(a5)
    80009274:	fff78793          	addi	a5,a5,-1
    80009278:	fff70713          	addi	a4,a4,-1
    8000927c:	00d70023          	sb	a3,0(a4)
    80009280:	fec798e3          	bne	a5,a2,80009270 <__memmove+0x12c>
    80009284:	00813403          	ld	s0,8(sp)
    80009288:	01010113          	addi	sp,sp,16
    8000928c:	00008067          	ret
    80009290:	02069713          	slli	a4,a3,0x20
    80009294:	02075713          	srli	a4,a4,0x20
    80009298:	00170713          	addi	a4,a4,1
    8000929c:	00e50733          	add	a4,a0,a4
    800092a0:	00050793          	mv	a5,a0
    800092a4:	0005c683          	lbu	a3,0(a1)
    800092a8:	00178793          	addi	a5,a5,1
    800092ac:	00158593          	addi	a1,a1,1
    800092b0:	fed78fa3          	sb	a3,-1(a5)
    800092b4:	fee798e3          	bne	a5,a4,800092a4 <__memmove+0x160>
    800092b8:	f89ff06f          	j	80009240 <__memmove+0xfc>

00000000800092bc <__putc>:
    800092bc:	fe010113          	addi	sp,sp,-32
    800092c0:	00813823          	sd	s0,16(sp)
    800092c4:	00113c23          	sd	ra,24(sp)
    800092c8:	02010413          	addi	s0,sp,32
    800092cc:	00050793          	mv	a5,a0
    800092d0:	fef40593          	addi	a1,s0,-17
    800092d4:	00100613          	li	a2,1
    800092d8:	00000513          	li	a0,0
    800092dc:	fef407a3          	sb	a5,-17(s0)
    800092e0:	fffff097          	auipc	ra,0xfffff
    800092e4:	b3c080e7          	jalr	-1220(ra) # 80007e1c <console_write>
    800092e8:	01813083          	ld	ra,24(sp)
    800092ec:	01013403          	ld	s0,16(sp)
    800092f0:	02010113          	addi	sp,sp,32
    800092f4:	00008067          	ret

00000000800092f8 <__getc>:
    800092f8:	fe010113          	addi	sp,sp,-32
    800092fc:	00813823          	sd	s0,16(sp)
    80009300:	00113c23          	sd	ra,24(sp)
    80009304:	02010413          	addi	s0,sp,32
    80009308:	fe840593          	addi	a1,s0,-24
    8000930c:	00100613          	li	a2,1
    80009310:	00000513          	li	a0,0
    80009314:	fffff097          	auipc	ra,0xfffff
    80009318:	ae8080e7          	jalr	-1304(ra) # 80007dfc <console_read>
    8000931c:	fe844503          	lbu	a0,-24(s0)
    80009320:	01813083          	ld	ra,24(sp)
    80009324:	01013403          	ld	s0,16(sp)
    80009328:	02010113          	addi	sp,sp,32
    8000932c:	00008067          	ret

0000000080009330 <console_handler>:
    80009330:	fe010113          	addi	sp,sp,-32
    80009334:	00813823          	sd	s0,16(sp)
    80009338:	00113c23          	sd	ra,24(sp)
    8000933c:	00913423          	sd	s1,8(sp)
    80009340:	02010413          	addi	s0,sp,32
    80009344:	14202773          	csrr	a4,scause
    80009348:	100027f3          	csrr	a5,sstatus
    8000934c:	0027f793          	andi	a5,a5,2
    80009350:	06079e63          	bnez	a5,800093cc <console_handler+0x9c>
    80009354:	00074c63          	bltz	a4,8000936c <console_handler+0x3c>
    80009358:	01813083          	ld	ra,24(sp)
    8000935c:	01013403          	ld	s0,16(sp)
    80009360:	00813483          	ld	s1,8(sp)
    80009364:	02010113          	addi	sp,sp,32
    80009368:	00008067          	ret
    8000936c:	0ff77713          	andi	a4,a4,255
    80009370:	00900793          	li	a5,9
    80009374:	fef712e3          	bne	a4,a5,80009358 <console_handler+0x28>
    80009378:	ffffe097          	auipc	ra,0xffffe
    8000937c:	6dc080e7          	jalr	1756(ra) # 80007a54 <plic_claim>
    80009380:	00a00793          	li	a5,10
    80009384:	00050493          	mv	s1,a0
    80009388:	02f50c63          	beq	a0,a5,800093c0 <console_handler+0x90>
    8000938c:	fc0506e3          	beqz	a0,80009358 <console_handler+0x28>
    80009390:	00050593          	mv	a1,a0
    80009394:	00001517          	auipc	a0,0x1
    80009398:	26c50513          	addi	a0,a0,620 # 8000a600 <CONSOLE_STATUS+0x5f0>
    8000939c:	fffff097          	auipc	ra,0xfffff
    800093a0:	afc080e7          	jalr	-1284(ra) # 80007e98 <__printf>
    800093a4:	01013403          	ld	s0,16(sp)
    800093a8:	01813083          	ld	ra,24(sp)
    800093ac:	00048513          	mv	a0,s1
    800093b0:	00813483          	ld	s1,8(sp)
    800093b4:	02010113          	addi	sp,sp,32
    800093b8:	ffffe317          	auipc	t1,0xffffe
    800093bc:	6d430067          	jr	1748(t1) # 80007a8c <plic_complete>
    800093c0:	fffff097          	auipc	ra,0xfffff
    800093c4:	3e0080e7          	jalr	992(ra) # 800087a0 <uartintr>
    800093c8:	fddff06f          	j	800093a4 <console_handler+0x74>
    800093cc:	00001517          	auipc	a0,0x1
    800093d0:	33450513          	addi	a0,a0,820 # 8000a700 <digits+0x78>
    800093d4:	fffff097          	auipc	ra,0xfffff
    800093d8:	a68080e7          	jalr	-1432(ra) # 80007e3c <panic>
	...

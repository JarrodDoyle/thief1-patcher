#! /usr/bin/env python

"""mkmot.py [opts] csv name
   Build motion data files from CSV text.

"""

import sys
import csv
from struct import pack
from operator import sub
from math import sqrt,sin,cos,asin,atan2,pi

__CretType = {
              "human" : 0x7FFFF,
              "humanwithsword" : 0xFFFFF,
              "droid" : 0x3FFFF,
              "spidbot" : 0xFF,
              "arachnid" : 0x1FFFFFFF,
              "plyrarm" : 0xE,
              "bugbeast" : 0x3FFFFF,
              "crayman" : 0x1FFFFF,
              "sweel" : 0x7F,
             }
__CretJoints = {
               0x7FFFF : ('Biped','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Neck','LShldr','RShldr','LElbow','RElbow','LWrist','RWrist','Abdomen'),
               0xFFFFF : ('Biped','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Neck','LShldr','RShldr','LElbow','RElbow','LWrist','RWrist','Abdomen'),
               0x3FFFF : ('Droid','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Abdomen','Neck','LShldr','RShldr','LElbow','RElbow'),
               0xFF : ('Arach','base','LMand','LMElbow','RMand','RMElbow','R1Shldr','R1Elbow','R1Wrist','R2Shldr','R2Elbow','R2Wrist','R3Shldr','R3Elbow','R3Wrist','R4Shldr','R4Elbow','R4Wrist','L1Shldr','L1Elbow','L1Wrist','L2Shldr','L2Elbow','L2Wrist','L3Shldr','L3Elbow','L3Wrist','L4Shldr','L4Elbow','L4Wrist','Sac'),
               0x1FFFFFFF : ('Spidey','base','LMand','LMElbow','RMand','RMElbow','R1Shldr','R1Elbow','R1Wrist','R2Shldr','R2Elbow','R2Wrist','R3Shldr','R3Elbow','R3Wrist','R4Shldr','R4Elbow','R4Wrist','L1Shldr','L1Elbow','L1Wrist','L2Shldr','L2Elbow','L2Wrist','L3Shldr','L3Elbow','L3Wrist','L4Shldr','L4Elbow','L4Wrist'),
               0xE : ('PlayArm','RShldr','RElbow','RWrist'),
               0x3FFFFF : ('BugBeast','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Neck','LShldr','RShldr','LElbow','RElbow','LWrist','RWrist','LFinger','RFinger','Abdomen'),
               0x1FFFFF : ('Crayman','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Neck','LShldr','RShldr','LElbow','RElbow','TPnchr','RWrist','Abdomen','BPnchr'),
               0x7F : ('Sweel','base','Back','Shldr','Neck','Head','Tail','Tip'),
               }
__JointMaps = {
               0x7FFFF : ((1,8),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,18)),
               0xFFFFF : ((1,8),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,18)),
               0x3FFFF : ((1,8),(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17)),
               0xFF : ((1,0),(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17),(0,18),(0,19),(0,20),(0,21),(0,22),(0,23),(0,24),(0,25),(0,26),(0,27),(0,28),(0,39)),
               0x1FFFFFFF : ((1,0),(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17),(0,18),(0,19),(0,20),(0,21),(0,22),(0,23),(0,24),(0,25),(0,26),(0,27),(0,28)),
               0xE : ((1,-1),(0,1),(0,2),(0,3)),
               0x3FFFFF : ((1,8),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17),(0,18)),
               0x1FFFFF : ((1,8),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,18)),
               0x7F : ((1,0),(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6)),
               }
__FrameFlags = {'stand'   : 0x001,
                'lfootdn' : 0x002,
                'rfootdn' : 0x004,
                'lfootup' : 0x008,
                'rfootup' : 0x010,
                'fire'    : 0x020,
                'interrupt':0x040,
                'start' :0x080,
                'end'  : 0x100,
                'f9'  : 0x200,
                'f10' : 0x400,
                'f11' : 0x800,
                'trig1' : 0x01000,
                'trig2' : 0x02000,
                'trig3' : 0x04000,
                'trig4' : 0x08000,
                'trig5' : 0x10000,
                'trig6' : 0x20000,
                'trig7' : 0x40000,
                'trig8' : 0x80000
                }

def CretType(c):
    c = c.strip('"\'').lower()
    if c in __CretType:
        return __CretType[c]
    raise ValueError("Unknown CretType: %s" % (c))

def JointName(j,c):
    if c in __CretJoints and j < len(__CretJoints[c]):
        return __CretJoints[c][j]
    return "j%02d"%(j)

def FlagNames(names):
    flags = 0
    for n in [n.strip().lower() for n in names.split(',')]:
        if n in __FrameFlags:
            flags |= __FrameFlags[n]
        else:
            try:
                f = int(n,0)
                flags |= f
            except ValueError:
                pass
    return flags

# 0 : quaternions, 1 : euler (radians), 2 : euler (degrees)
quat_output_type = 0
centralize = False
separate_columns = False

__radians = 180.0 / pi
__2_pi = 2.0 * pi
__epsilon = 0.000001

def wraparound_r(a,b):
    v = a
    if abs(a[0] - b[0]) > pi:
        if a[0] > b[0]:
            v = [a[0] - __2_pi, v[1], v[2]]
        else:
            v = [a[0] + __2_pi, v[1], v[2]]
    if abs(a[1] - b[1]) > pi:
        if a[1] > b[1]:
            v = [v[0], a[1] - __2_pi, v[2]]
        else:
            v = [v[0], a[1] + __2_pi, v[2]]
    if abs(a[2] - b[2]) > pi:
        if a[2] > b[2]:
            v = [v[0], v[1], a[2] - __2_pi]
        else:
            v = [v[0], v[1], a[2] + __2_pi]
    return tuple(v)

def wraparound_d(a,b):
    v = a
    if abs(a[0] - b[0]) > 300.0:
        if a[0] > b[0]:
            v = [a[0] - 360.0, v[1], v[2]]
        else:
            v = [a[0] + 360.0, v[1], v[2]]
    if abs(a[1] - b[1]) > 300.0:
        if a[1] > b[1]:
            v = [v[0], a[1] - 360.0, v[2]]
        else:
            v = [v[0], a[1] + 360.0, v[2]]
    if abs(a[2] - b[2]) > 300.0:
        if a[2] > b[2]:
            v = [v[0], v[1], a[2] - 360.0]
        else:
            v = [v[0], v[1], a[2] + 360.0]
    return tuple(v)

def r_to_d(r):
    i = r[0] * __radians
    j = r[1] * __radians
    k = r[2] * __radians
    #if i < 0:
    #    i += 360.0
    #if j < 0:
    #    j += 360.0
    #if k < 0:
    #    k += 360.0
    return (i,j,k)

def d_to_r(d):
    i = r[0] / __radians
    j = r[1] / __radians
    k = r[2] / __radians
    return (i,j,k)

def q_to_v(q):
    j = asin( 2*(q[1]*q[3] + q[2]*q[0]) )
    if j <= __epsilon:
        j = 0.0
    cj = cos(j)
    if abs(cj) > __epsilon:
        if abs(1.0-cj) <= __epsilon:
            cj = 1.0
        ci = (1 - 2*(q[1]*q[1] + q[2]*q[2])) / cj
        si = (2*(q[1]*q[0] - q[2]*q[3])) / cj
        ck = (1 - 2*(q[2]*q[2] + q[3]*q[3])) / cj
        sk = (2*(q[3]*q[0] - q[1]*q[2])) / cj
        i = atan2(si,ci)
        k = atan2(sk,ck)
    else:
        i = 0.0
        ck = 1 - 2*(q[1]*q[1] + q[3]*q[3])
        sk = 2*(q[1]*q[2] + q[3]*q[0])
        k = atan2(sk,ck)
    return (i,j,k)

def m_to_q(mx):
    tr = 1 + mx[0][0] + mx[1][1] + mx[2][2]
    q = [0.0,0.0,0.0,0.0]
    if tr > 0.00000001:
        s = sqrt(tr)
        q[0] = s * 0.5
        s = 0.5 / s
        q[1] = (mx[1][2] - mx[2][1]) * s
        q[2] = (mx[2][0] - mx[0][2]) * s
        q[3] = (mx[0][1] - mx[1][0]) * s
    else:
        d = [mx[0][0], mx[1][1], mx[2][2]]
        d = d.index(max(d))
        if d == 2:
            s = sqrt(1.0 + mx[2][2] - mx[0][0] - mx[1][1])
            q[3] = s * 0.5
            s = 0.5 / s
            q[1] = (mx[0][2] + mx[2][0]) * s
            q[2] = (mx[2][1] + mx[1][2]) * s
            q[0] = (mx[0][1] - mx[1][0]) * s
        elif d == 1:
            s = sqrt(1.0 + mx[1][1] - mx[0][0] - mx[2][2])
            q[2] = s * 0.5
            s = 0.5 / s
            q[3] = (mx[2][1] + mx[1][2]) * s
            q[1] = (mx[1][0] + mx[0][1]) * s
            q[0] = (mx[2][0] - mx[0][2]) * s
        else:
            s = sqrt(1.0 + mx[0][0] - mx[1][1] - mx[2][2])
            q[1] = s * 0.5
            s = 0.5 / s
            q[2] = (mx[1][0] + mx[0][1]) * s
            q[3] = (mx[0][2] + mx[2][0]) * s
            q[0] = (mx[1][2] - mx[2][1]) * s
    return tuple(q)

def v_to_m(v):
    sv = map(sin, v)
    cv = map(cos, v)
    mx = ((cv[1]*cv[2], sv[0]*sv[1]*cv[2] + cv[0]*sv[2], -cv[0]*sv[1]*cv[2] + sv[0]*sv[2]), 
         (-cv[1]*sv[2], -sv[0]*sv[1]*sv[2] + cv[0]*cv[2], cv[0]*sv[1]*sv[2] + sv[0]*cv[2]), 
         (sv[1], -sv[0]*cv[1], cv[0]*cv[1]))
    return mx

def v_to_q(v):
    return m_to_q(v_to_m(v))

def pack_vector(v):
    return pack('%df' % (len(v)), *v)

def read_vector(l):
    v = []
    for c in l:
        try:
            f = float(c)
        except ValueError:
            f = 0.0
        v.append(f)
    return tuple(v)

def read_quaternion(v):
    if quat_output_type == 0:
        return v
    if quat_output_type == 2:
        v = d_to_r(v)
    return v_to_q(v)

def multicol_name(n):
    l = n[0] + '.x,' + n[0] + '.y,' + n[0] + '.z'
    for s in n[1:]:
        if quat_output_type == 0:
            l += ',' + s + '.w'
        l += ',' + s + '.x,' + s + '.y,' + s + '.z'
    return l

def main(fnin,fnout):
    cret = None
    fps = 30
    motname = ""
    centralize = False
    fin = file(fnin,'rb')
    head = fin.readline()
    while head and head[0] == ';':
        (parm,val) = [s.strip() for s in head[1:].split('=',1)]
        if parm == 'creature_type':
            cret = CretType(val)
        if parm == 'fps':
            fps = int(val)
        if parm == 'name':
            motname = val
        if parm == 'centralize':
            centralize = True
            raise NotImplementedError("I don't handle centralized vectors yet")
        if parm == 'radians':
            quat_output_type = 1
        if parm == 'degrees':
            quat_output_type = 2
        head = fin.readline()
    if not head or cret is None:
        sys.exit(0)
    cols = [s.strip() for s in head.split(',')]
    if cols[0] != 'flags' or not cols[1].startswith('pos'):
        raise ValueError("Cowardly refusing to read unfamiliar data.")
    if cols[1] == 'pos':
        separate_columns = False
        numjoints = len(cols) - 1
    else:
        separate_columns = True
        if quat_output_type == 0:
            numjoints = len(cols) // 4
        else:
            numjoints = (len(cols)-1) // 3
    if numjoints != len(__CretJoints[cret]):
        raise ValueError("Wrong number of joints (%d) for CretType (%X)" % (numjoints,cret))
    flags = []
    joints = [[] for j in range(numjoints)]
    if quat_output_type == 0:
        col_count = 4
    else:
        col_count = 3
    rows = csv.reader(fin)
    for frame,row in enumerate(rows):
        f = FlagNames(row[0])
        if f != 0:
            flags.append((frame,f))
        if not separate_columns:
            v = row[1].strip('"\'(),').split(',')
        else:
            v = row[1:4]
        joints[0].append(read_vector(v))
        if separate_columns:
            for j,c in enumerate(range(4,len(row),col_count)):
                q = read_vector(row[c:c+col_count])
                joints[j+1].append(read_quaternion(q))
        else:
            for j,c in enumerate(row[2:]):
                q = read_vector(c.strip('"\'(),').split(','))
                joints[j+1].append(read_quaternion(q))
    numframes = len(joints[0])
    mi = file(fnout+'.mi','wb')
    mc = file(fnout+'_.mc','wb')
    mi.write(pack('4xlfl4x12s', cret, numframes, fps, motname))
    mi.write('\0'*64)
    mi.write(pack('L4xL4x', numjoints, len(flags)))
    for n,j in enumerate(__JointMaps[cret]):
        mi.write(pack('3l', j[0], j[1], n))
    for n,f in flags:
        mi.write(pack('2L', n, f))
    mi.close()
    mc.write(pack('L', numjoints))
    mapsize = (((numjoints*4) + 11) // 8) * 8
    mc.write(pack('L', mapsize))
    offset = mapsize + numframes * 12
    for j in range(numjoints-1):
        mc.write(pack('L', offset))
        offset += numframes * 16
    pad = mapsize - ((numjoints*4) + 4)
    mc.write('\0'*pad)
    for j in joints:
        for v in j:
            mc.write(pack_vector(v))

if __name__ == '__main__':
    if len(sys.argv) == 3:
        main(sys.argv[1], sys.argv[2])

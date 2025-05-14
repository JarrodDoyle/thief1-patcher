#! /usr/bin/env python

"""mot.py [opts] name ...
   Dump a motion data file as CSV text.

   -r : use euler angles in radians (default)
   -d : use euler angles in degrees
   -q : use quaternions
   -c : use angles relative to a base row (only for -r and -d)
   -s : use separate columns for each component
   'name' is the basename of the motions. '.mi' will be appended to get 
   the header file. '_.mc' will be appended to get the joint data.

   The values reported here aren't the same as what is shown in Weyoun's
   MotEdit.exe. I believe that I'm doing it the "right" way.
"""

import sys
from struct import unpack
from operator import sub
from math import sqrt,sin,cos,asin,atan2,pi

__CretType = {
             0x7FFFF : "Human",
             0xFFFFF : "HumanWithSword",
             0x3FFFF : "Droid",
             0xFF : "SpidBot",
             0x1FFFFFFF : "Arachnid",
             0xE : "PlyrArm",
             0x3FFFFF : "BugBeast",
             0x1FFFFF : "Crayman",
             0x7F : "Sweel",
             }
__CretJoints = {
               0x7FFFF : ('Biped','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Neck','LShldr','RShldr','LElbow','RElbow','LWrist','RWrist','Abdomen'),
               0xFFFFF : ('Biped','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Neck','LShldr','RShldr','LElbow','RElbow','LWrist','RWrist','Abdomen'),
               0x3FFFF : ('Droid','LAnkle','RAnkle','LKnee','RKnee','LHip','RHip','Butt','Abdomen','Neck','LShldr','RShldr','LElbow','RElbow'),
               0xFF : ('Arach','base','LMand','LMElbow','RMand','RMElbow','R1Shldr','R1Elbow','R1Wrist','R2Shldr','R2Elbow','R2Wrist','R3Shldr','R3Elbow','R3Wrist','R4Shldr','R4Elbow','R4Wrist','L1Shldr','L1Elbow','L1Wrist','L2Shldr','L2Elbow','L2Wrist','L3Shldr','L3Elbow','L3Wrist','L4Shldr','L4Elbow','L4Wrist'),
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
               0xFF : ((1,0),(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17),(0,18),(0,19),(0,20),(0,21),(0,22),(0,23),(0,24),(0,25),(0,26),(0,27),(0,28)),
               0x1FFFFFFF : ((1,0),(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17),(0,18),(0,19),(0,20),(0,21),(0,22),(0,23),(0,24),(0,25),(0,26),(0,27),(0,28)),
               0xE : ((1,-1),(0,1),(0,2),(0,3)),
               0x3FFFFF : ((1,8),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,16),(0,17),(0,18)),
               0x1FFFFF : ((1,8),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),(0,11),(0,12),(0,13),(0,14),(0,15),(0,18)),
               0x7F : ((1,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6)),
               }
__FrameFlags = ('Stand','LFootDn','RFootDn','LFootUp',
                'RFootUp','Fire','Interrupt','Start',
                'End','F9','F10','F11',
                'Trig1','Trig2','Trig3','Trig4','Trig5','Trig6','Trig7','Trig8')

def CretType(c):
    if c in __CretType:
        return repr(__CretType[c])
    return "0x%X" % (c)

def JointName(j,c):
    if c in __CretJoints and j < len(__CretJoints[c]):
        return __CretJoints[c][j]
    return "j%02d"%(j)

def FlagNames(f):
    names = []
    i = iter(__FrameFlags)
    try:
        b = 1
        while f >= b:
            n = i.next()
            if f & b:
                names.append(n)
            b <<= 1
    except StopIteration:
        n = '0x%X' % (f & ~(b - 1))
        names.append(n)
    return ','.join(names)

# 0 : quaternions, 1 : euler (radians), 2 : euler (degrees)
quat_output_type = 1
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

def write_quaternion(q,c):
    if quat_output_type == 0:
        if separate_columns:
            return '%.8f,%.8f,%.8f,%.8f'%q
        return '"(%.8f,%.8f,%.8f,%.8f)"'%q
    v = q_to_v(q)
    v = map(sub,v,c)
    if quat_output_type == 2:
        v = r_to_d(v)
    if separate_columns:
        return '%.8f,%.8f,%.8f'%v
    return '"(%.8f,%.8f,%.8f)"'%v

def write_vector(v):
    if v:
        s = ','.join(['%.8f'%x for x in v])
    else:
        s = '0.0,0.0,0.0'
    if separate_columns:
        return s
    return '"(' + s + ')"'

def multicol_name(n):
    l = n[0] + '.x,' + n[0] + '.y,' + n[0] + '.z'
    for s in n[1:]:
        if quat_output_type == 0:
            l += ',' + s + '.w'
        l += ',' + s + '.x,' + s + '.y,' + s + '.z'
    return l

def main(fn):
    mi = file(fn+'.mi','rb')
    mc = file(fn+'_.mc','rb')
    (cret,numframes,fps) = unpack('4xlfl4x', mi.read(20))
    numframes = int(numframes)
    motname = mi.read(12)
    if motname.find('\0') != -1:
        motname = motname[:motname.find('\0')]
    mi.seek(64 ,1)
    (numjoints,numflags) = unpack('l4xl4x', mi.read(16))
    mi.seek(numjoints*12, 1)
    flags = {}
    for f in range(numflags):
        (frame,flag) = unpack('lL', mi.read(8))
        flags[frame] = flags.get(frame, 0) | flag
    (numjoints,) = unpack('L', mc.read(4))
    frames = [[None for j in range(numjoints)] for f in range(numframes + 1)]
    if numjoints > 0:
        jointmap = unpack("%dL"%(numjoints), mc.read(4*numjoints))
        mc.seek(jointmap[0],0)
        #print model_position = ["
        frames[0][0] = 'pos'
        for f in range(1,numframes+1):
            v = list(unpack('3f', mc.read(12)))
            if abs(v[0]) < __epsilon:
                v[0] = 0.0
            if abs(v[1]) < __epsilon:
                v[1] = 0.0
            if abs(v[2]) < __epsilon:
                v[2] = 0.0
            frames[f][0] = tuple(v)
            #print "                 (%.8f, %.8f, %.8f)%s" % (v[0],v[1],v[2],(f<numframes-1) and ',' or '')
        #print "                 ]"
        for j in range(1,numjoints):
            mc.seek(jointmap[j],0)
            #print "joint_%02d = [" % (j)
            frames[0][j] = JointName(j,cret)
            for f in range(1,numframes+1):
                q = list(unpack('4f', mc.read(16)))
                if abs(q[0]) < __epsilon:
                    q[0] = 0.0
                if abs(q[1]) < __epsilon:
                    q[1] = 0.0
                if abs(q[2]) < __epsilon:
                    q[2] = 0.0
                if abs(q[3]) < __epsilon:
                    q[3] = 0.0
                frames[f][j] = tuple(q)
                #print "           (%.8f, %.8f, %.8f, %.8f)%s" % (q[0],q[1],q[2],q[3],(f<numframes-1) and ',' or '')
            #print "           ]"
    if quat_output_type != 0:
        for f in range(1,numframes+1):
            for j in range(1,numjoints):
                frames[f][j] = q_to_v(frames[f][j])
                if quat_output_type == 2:
                    frames[f][j] = r_to_d(frames[f][j])
                if f > 1:
                    if quat_output_type == 2:
                        frames[f][j] = wraparound_d(frames[f][j], frames[f-1][j])
                    else:
                        frames[f][j] = wraparound_r(frames[f][j], frames[f-1][j])
        if centralize:
            c = [(0.0,0.0,0.0) for j in range(numjoints)]
            for j in range(1,numjoints):
                red = list(frames[1][j])
                black = list(red)
                for f in range(2,numframes+1):
                    v = frames[f][j]
                    if v[0] < red[0]:
                        red[0] = v[0]
                    elif v[0] > black[0]:
                        black[0] = v[0]
                    if v[1] < red[1]:
                        red[1] = v[1]
                    elif v[1] > black[1]:
                        black[1] = v[1]
                    if v[2] < red[2]:
                        red[2] = v[2]
                    elif v[2] > black[2]:
                        black[2] = v[2]
                c[j] = tuple(map(lambda a,b: (a+b)*0.5, red, black))
            for f in range(1,numframes+1):
                for j in range(numjoints):
                    frames[f][j] = tuple(map(sub,frames[f][j],c[j]))
            frames.insert(1,c)
    sys.stdout.write(";name = " + motname + '\n')
    sys.stdout.write(";creature_type = " + CretType(cret) + '\n')
    sys.stdout.write(";fps = " + str(fps) + '\n')
    sys.stdout.write(";num_frames = " + str(numframes) + '\n')
    if centralize:
        sys.stdout.write(";centralize = True\n")
    if quat_output_type == 1:
        sys.stdout.write(";radians = True\n")
    if quat_output_type == 2:
        sys.stdout.write(";degrees = True\n")
    #print ""
    sys.stdout.write('flags,')
    if separate_columns:
        sys.stdout.write(multicol_name(frames[0]))
    else:
        sys.stdout.write(','.join(frames[0]))
    sys.stdout.write('\n')
    for n,f in enumerate(frames[1:]):
        if centralize:
            n -= 1
        if n in flags:
            sys.stdout.write('"'+FlagNames(flags[n])+'",')
        else:
            sys.stdout.write('"",')
        sys.stdout.write(write_vector(f[0]))
        for j in f[1:]:
            sys.stdout.write(',')
            sys.stdout.write(write_vector(j))
            #if id(j) != id(f[-1]):
        sys.stdout.write('\n')

if __name__ == '__main__':
    for n in range(1,len(sys.argv)):
        if sys.argv[n].startswith('-'):
            if sys.argv[n][1] == 'q':
                quat_output_type = 0
            elif sys.argv[n][1] == 'r':
                quat_output_type = 1
            elif sys.argv[n][1] == 'd':
                quat_output_type = 2
            elif sys.argv[n][1] == 'c':
                centralize = True
            elif sys.argv[n][1] == 's':
                separate_columns = True
        else:
            break
    else:
        q = v_to_q((pi*0.25,pi*0.15,pi*0.25))
        print q
        v = q_to_v(q)
        print v
        print v_to_q(v)
        print q_to_v(v_to_q(v))
        print v_to_m(v)
        sys.exit(0)
    for fn in sys.argv[n:]:
        main(fn)

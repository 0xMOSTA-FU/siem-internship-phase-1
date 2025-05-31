Hello my friends,
This is Mostafa Essam (0xMOST) with you. Today, in this file, we’ll start talking about the steps and everything we did to set up this lab.
I'm excited as I write this, so I hope you're just as excited!
Let’s get started.

>  **Important Note:**  
> I did **not** use a static IP address in my lab setup.  
> As a result, the IP address **changed every time** I shut down and restarted the system.  
> The only thing I updated was the IP **inside Winlogbeat** to match the new one each time.
> like that :
> 
![Screenshot 2025-05-13 003558](https://github.com/user-attachments/assets/34e1030d-80fd-4573-99ce-b8d9f361dcde)
![Screenshot 2025-05-14 162428](https://github.com/user-attachments/assets/e55b6fcb-18e7-4fee-9190-f6061c75a877)
![Screenshot 2025-05-15 053846](https://github.com/user-attachments/assets/58fdb6fd-c27e-4e1d-8964-d76a362e4c29)
![image](https://github.com/user-attachments/assets/3780bb75-281a-428a-b26f-6251965f18ba)


In the beginning, we’ll need to download software that allows us to run virtual machines, such as **VMware** or **VirtualBox**.
We’ll also need to download a **Windows 10** image, and we can get the ISO file from the official **Microsoft website**.

Additionally, we’ll download a Linux machine, whether it’s **Ubuntu**, **Parrot**, **Kali**, etc.



---

##  What Is Virtualization?

**Virtualization** is a technology that allows you to run **multiple operating systems (OS)** on a **single physical machine**, as if each OS has its own separate hardware.

![image](https://github.com/user-attachments/assets/3db7c991-bb3d-4e3f-b45c-28af8153b472)


For example:

* You have a physical laptop running Windows 11.
* Using virtualization, you can run Ubuntu Linux or Windows 10 **inside** your Windows 11, at the same time.
* Each OS runs in a **Virtual Machine (VM)**, which behaves like an independent computer.

---

##  How Does Virtualization Actually Work?

There are **3 main components** in virtualization:

### 1. **Host Machine**

This is your **real physical computer** — the one with actual hardware (CPU, RAM, hard drive, etc.).

### 2. **Hypervisor**

This is the **software** that allows multiple virtual machines to run on a host machine by creating and managing virtual hardware for each VM.

There are two types of hypervisors:

| Type                    | Description                                             | Examples                                     |
| ----------------------- | ------------------------------------------------------- | -------------------------------------------- |
| **Type 1 (Bare-metal)** | Runs **directly on the hardware**, no host OS           | VMware ESXi, Microsoft Hyper-V (Server), KVM |
| **Type 2 (Hosted)**     | Runs **on top of an existing OS** like Windows or Linux | VirtualBox, VMware Workstation, Parallels    |

> If you're using VirtualBox on Windows, that's **Type 2** virtualization.

### 3. **Virtual Machine (VM)**

A VM is a **software-based computer** that runs its own operating system (Windows, Linux, etc.) and behaves like a real machine — but it's actually running **inside** your host system via the hypervisor.

---

##  What Happens Behind the Scenes When a VM Runs?

1. The **hypervisor** takes a portion of your real hardware resources (CPU, RAM, disk, etc.) and assigns them to the VM.
2. It creates **virtual hardware** (virtual CPU, virtual RAM, virtual hard disk, virtual network card, etc.).
3. You install an operating system (like Linux or Windows) **inside** the VM — just like on a physical machine.
4. The OS inside the VM doesn’t know it’s virtualized. It thinks it’s running on real hardware.

> Example: If your physical machine has 16 GB RAM, you can create a VM and give it 4 GB. The VM thinks it has a 4 GB physical RAM, but it's actually just a portion.

---

##  How Do Different OSes Like Windows and Linux Run Together?

* Each VM runs **independently** with its own OS (e.g., Ubuntu, Windows 10).
* Each OS sees **virtual hardware** and interacts with it normally.
* The **hypervisor translates** those interactions into real hardware calls for your host machine.

In simple terms:

* Linux in one VM thinks it's running on a real machine.
* Windows in another VM also thinks it has its own hardware.
* The hypervisor manages all of this behind the scenes on the same host device.

---

##  Is Performance Good? Any Drawbacks?

* Yes, performance is **usually good**, especially on modern CPUs that support virtualization (Intel VT-x or AMD-V).
* However, performance is **slightly lower** than running on real hardware because of the extra virtualization layer.
* Some tasks (like 3D graphics or gaming) may be slower unless you enable GPU passthrough.

---

##  Why Use Virtualization? (Use Cases)

1. **Learning & Testing**: Try Linux, macOS, or Windows without affecting your main system.
2. **Development & QA**: Developers can test apps on different OSes easily.
3. **Security Research**: Run malware in a safe, isolated VM.
4. **Data Centers**: One physical server can host dozens or hundreds of VMs.
5. **Disaster Recovery**: Easier to back up and restore full virtual machines.

---

##  Common Hypervisors

| Hypervisor                         | Type   | Platform           |
| ---------------------------------- | ------ | ------------------ |
| VMware Workstation                 | Type 2 | Windows/Linux      |
| VirtualBox                         | Type 2 | Free & open-source |
| VMware ESXi                        | Type 1 | Enterprise-grade   |
| Microsoft Hyper-V                  | Both   | Windows            |
| KVM (Kernel-based Virtual Machine) | Type 1 | Linux-based        |

---

##  Virtual Machine vs Dual Boot

| Dual Boot                                                  | Virtual Machine                     |
| ---------------------------------------------------------- | ----------------------------------- |
| Install multiple OSes on your disk and pick one at startup | Run one OS inside another           |
| Full access to hardware                                    | Shares hardware with the host       |
| Requires reboot to switch OS                               | Switch instantly while running both |

---

##  Containers vs Virtual Machines (Advanced)

* **Virtual Machines** virtualize **hardware**.
* **Containers** (like Docker) virtualize **software environments** — much lighter and faster but **share the same OS kernel**.

---

After talking about the tools we need to download and discussing the concept of **virtualization**, let’s move on to the next step, which is **setting up our lab from scratch**.


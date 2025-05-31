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

Alright, first we need to set up the machines. I chose **Parrot OS**, which is a Linux-based machine, to host our **SIEM** system.
I also created another machine running **Windows 10**, which I’ll connect to the SIEM to send logs from and use to test the rules.

So, in this case, our **log source** is **Windows 10**.

I’ll show you some images shortly to demonstrate how to create these machines step by step—stay tuned.
For this task, I’m using **VMware**, but you’re free to use any other tool you prefer—no problem at all.
To begin, after opening **VMware**, we need to create a new virtual machine for **Linux**.

First, go to the top menu, click on **File**, then select **New Virtual Machine Wizard**, or simply press **Ctrl + N**.
![image](https://github.com/user-attachments/assets/93652caa-9466-4074-bea5-fe20a6f0a094)

This image displays the "File" menu within the VMware Workstation interface. This menu is the starting point for many fundamental operations related to virtual machine management. The red arrow highlights the most relevant option for creating a new virtual machine.

Here's a breakdown of the options:

1.  **New Virtual Machine... (Ctrl+N)**
    * **Explanation:** This is the primary option to create a completely new virtual machine from scratch. Clicking it (or using `Ctrl+N`) launches the "New Virtual Machine Wizard," which guides you through configuring the VM's resources and installing an operating system.
    * **Use case:** To build any new VM for testing, isolated environments, or server setup.

2.  **New Window**
    * **Explanation:** Opens another VMware Workstation window, useful for managing multiple VMs or projects simultaneously.
    * **Use case:** For better organization when working with many VMs.

3.  **Open... (Ctrl+O)**
    * **Explanation:** Allows you to load an existing virtual machine by selecting its configuration file (typically a `.vmx` file).
    * **Use case:** To start using a VM that was previously created or copied.

4.  **Scan for Virtual Machines...**
    * **Explanation:** Scans specified drives for VM files that might exist but aren't yet listed in your VMware Workstation library.
    * **Use case:** To add manually moved or external VMs to your recognized list.

5.  **Configure Auto Start VMs**
    * **Explanation:** Lets you define which VMs should automatically power on when the host computer starts (or when the VMware Workstation service begins).
    * **Use case:** For VMs that need to be continuously running, like virtual servers or always-on test environments.

6.  **Close Tab (Ctrl+W)**
    * **Explanation:** Closes the currently active tab in the VMware Workstation interface. If a VM is running, it will prompt you to power it off or suspend it first.
    * **Use case:** To close a VM's view without exiting the application.

7.  **Connect to Server... (Ctrl+L)**
    * **Explanation:** Allows you to connect to a VMware vCenter Server or ESXi Host to manage VMs hosted on those enterprise-level servers.
    * **Use case:** For administrators managing larger vSphere/ESXi environments.

8.  **Export to OVF...**
    * **Explanation:** Exports a VM or group of VMs into the OVF (Open Virtualization Format) or OVA format. This is an open standard for VM portability between different virtualization products.
    * **Use case:** For sharing VMs, migrating them to different virtualization platforms, or creating standardized backups.

9.  **Exit**
    * **Explanation:** Closes the entire VMware Workstation application. It will prompt you to save changes or shut down running VMs.
    * **Use case:** To completely close the application when you're done.

![image](https://github.com/user-attachments/assets/74adda5e-f365-4ebd-b26a-d20e51aa9a94)

the screen from the "New Virtual Machine Wizard" in VMware Workstation Pro 17:

This is the initial welcome screen for creating a new virtual machine (VM). It asks you what type of configuration you want for the VM.

Here are the options:

1.  **Typical (recommended)**
    * **Description:** This is the default and recommended option for most users. It simplifies the VM creation process by automatically setting common and efficient configurations. VMware Workstation handles details like virtual disk type, network settings, and default memory size, based on the OS you intend to install.
    * **Use case:** Ideal if you want to quickly create a VM with minimal fuss for general purposes like testing new OS, running specific applications, or simple lab setups.

2.  **Custom (advanced)**
    * **Description:** This option gives you full, granular control over every aspect of the VM's configuration. You'll go through additional screens to specify details like:
        * **Virtual machine compatibility:** For transferring VMs to older VMware products (Workstation or ESXi).
        * **SCSI controller type:** Affects performance and compatibility with the guest OS.
        * **Virtual disk type:** (e.g., IDE, SCSI, SATA).
        * Advanced network options, CPU cores, etc.
    * **Use case:** For advanced users with specific requirements, compatibility needs (e.g., for older OS or specific software), or when optimizing performance.

**Summary/Recommendation:**

* For most users and everyday tasks, choose **"Typical (recommended)"** for a quick and easy setup with good default settings.
* If you are an experienced user or have very specific technical requirements, choose **"Custom (advanced)"** for complete control over the VM's configuration.

![image](https://github.com/user-attachments/assets/79620c2b-5a1f-4350-af05-ab9c1eecd917)

This screen guides you on how to install the operating system (OS) onto your new virtual machine (VM). A VM functions like a real computer and requires an OS to operate.

Here are the options:

1.  **Install from:**
    * **Installer disc:**
        * Used if you want to install the OS from a physical disc (CD/DVD) in your host computer's drive.
        * "No drives available" means no physical drive is detected or recognized.
        * **Use case:** When you have a physical installation disc for an OS.
    * **Installer disc image file (iso):**
        * **Most common and recommended option.** This allows you to select an ISO file, which is a complete digital copy of an installation disc.
        * For Example: The path shown (`D:\...\ويندوزh2_release_`) indicates an ISO file for Windows.
        * "Browse..." allows you to locate the ISO file on your computer.
        * **Use case:** When you have downloaded an OS as an ISO file (e.g., Windows, Linux distributions).
    * **I will install the operating system later.**
        * This option creates the VM with a blank hard disk, without installing the OS immediately.
        * You'll configure the VM's hardware (RAM, CPU, disk size) first, and then install the OS manually when you power on the VM for the first time.
        * **Use case:** If you want to set up the VM's configuration first, or plan to use advanced/network-based installation methods, or don't have the OS media ready yet.

**Summary/Recommendation:**

For most users, **"Installer disc image file (iso)" is the best and most convenient choice.** Download the OS as an ISO file and select it. "I will install the operating system later" is useful if you want to set up the VM's hardware first or use custom installation methods.
![image](https://github.com/user-attachments/assets/c9072ff2-e4c0-4093-9978-4e46e0a43ab6)
 information about Parrot OS:
* **Based on Debian Testing:** Parrot OS continues to be based on Debian's "testing" branch (currently codenamed "Trixie"). This provides a balance of up-to-date packages and reasonable stability.
* **Rolling Release Model:** Parrot OS follows a rolling release development model. This means continuous updates for packages, applications, and the Linux kernel, eliminating the need for full re-installations with major releases and ensuring users always have the latest tools and security patches.
* **Linux Kernel Version:** While previous versions used Linux Kernel 6.1, Parrot OS, due to its rolling release nature, now utilizes newer kernel versions (e.g., Parrot 6.3 uses Linux kernel 6.11.5 or later). The kernel is regularly updated.
* **Debian 13 Codename:** "Trixie" remains the development codename for Debian 13. As of March 2025, the "Trixie" branch has entered its "freeze" phase, moving towards its stable release later in 2025.

![image](https://github.com/user-attachments/assets/faa60f7f-4408-42ac-91ac-d5979f85b032)

![image](https://github.com/user-attachments/assets/3de6be36-765f-4f0a-a040-fe41aa29bc6c)

when you're going to select the version for Parrot OS in VMware, what exactly do you choose? Linux 6.x or Debian?

The short and helpful answer for you is: **You should choose `Debian`**.

And why choose Debian? For a few reasons:

1.  **Parrot OS is fundamentally based on Debian:** Look, boss, even though Parrot OS has its own tools and specific additions, its core foundation is Debian. It's like a cousin to Debian. When you choose "Debian" in VMware, the program understands that you're installing a Debian-based system and it sets up the configurations that work best for it.
2.  **VMware communicates using fundamental names:** The options that appear in VMware are usually for the well-known, foundational distribution names. When you pick "Debian," it signals to VMware to adjust things like the default virtual display adapter, network card, and other settings to work perfectly with systems from the Debian family.
3.  **Linux 6.x is a kernel version, not a distribution:** "Linux 6.x" refers specifically to the "Kernel" version (the core of Linux) that the system uses, not the name of the distribution itself. So, while Parrot OS does use a 6.x kernel (or even newer, as we discussed), choosing "Linux 6.x" as the *distribution* option in VMware might not be precise enough and might not allow VMware to set the best possible configurations compared to explicitly selecting "Debian."

**In short: Whenever you have the option to choose the base distribution, pick that. For Parrot OS, its base distribution is Debian.**

![image](https://github.com/user-attachments/assets/9a7a65ff-57b0-4f15-8a73-8dd3cbb24a89)

 (Name the Virtual Machine):

Explanation: This step allows you to name your virtual machine and choose its storage location on your host computer.
Purpose: Assigns a name and specifies the storage path for the VM files.

![image](https://github.com/user-attachments/assets/90d4e070-e4df-49c3-845f-2845244938c6)
(Specify Disk Capacity):

* **Explanation:** This screen lets you set the size of the virtual hard disk for your VM and how its files are stored on your physical computer.
    * **Maximum disk size (GB):** You specify the largest amount of space the virtual disk can take.
    * **Recommended size:** VMware suggests a size (e.g., 20 GB for Debian) for optimal performance and basic usage.
    * **Store virtual disk as a single file:** All the VM's disk data is kept in one large file.
    * **Split virtual disk into multiple files:** The VM's disk data is broken into smaller files, which can make it easier to move the VM, but might slightly reduce performance for very large disks.
* **Purpose:** To define the size and storage method of the VM's virtual hard drive.
![image](https://github.com/user-attachments/assets/39cc8345-1379-47f5-b0ae-402f31fc6153)

**(Ready to Create Virtual Machine):**

* **Explanation:** This is the final step in the New Virtual Machine Wizard. This screen provides a summary of all the settings you've chosen for your virtual machine before it's actually created.
    * **Name:** The name you assigned to your virtual machine (e.g., "Parrot test").
    * **Location:** The path on your host computer where the virtual machine's files will be stored.
    * **Version:** The VMware Workstation version with which this virtual machine will be compatible.
    * **Operating System:** The guest operating system you selected (e.g., "Debian 12.x 64-bit").
    * **Hard Disk:** The size of the virtual hard disk (e.g., "20 GB") and how it's stored (e.g., "Split" into multiple files).
    * **Memory:** The amount of RAM allocated to the virtual machine (e.g., "2048 MB = 2 GB").
    * **Network Adapter:** The type of network connection (e.g., "NAT").
    * **Other Devices:** A summary of other virtual hardware components, such as the number of CPU cores (e.g., "2 CPU cores"), CD/DVD drive, USB controller, and Sound Card.
* **Customize Hardware...:** This button allows you to go back and modify any hardware settings (like RAM, processor, hard disk, network) before finalizing.
* **Finish:** Clicking this button tells VMware to proceed with creating the virtual machine with the summarized settings, making it ready for you to power on and install the operating system.
* **Purpose:** To review and confirm the final configuration settings of the virtual machine before its creation, offering a last chance for modifications.

  
![image](https://github.com/user-attachments/assets/5d483cb9-1e88-493e-b4e3-b75a57a211ae)

Power on This Machine.

![image](https://github.com/user-attachments/assets/5276f3c1-f953-4092-9f3a-d5ca95906c90)

![image](https://github.com/user-attachments/assets/0d790b06-33a4-49f8-833c-415ad75e82da)

![image](https://github.com/user-attachments/assets/27fa62d9-5ac6-4056-af3d-da98b85d8854)


![image](https://github.com/user-attachments/assets/b8c8e615-7617-4d35-bdcd-fcec40a1ec46)

![image](https://github.com/user-attachments/assets/0ab3be79-468a-4373-bb92-17af7ea67b11)

![image](https://github.com/user-attachments/assets/d5074c42-de13-477e-b868-b5218e190078)

![image](https://github.com/user-attachments/assets/41b26cd6-c048-4c43-9182-6495dc58a195)

![image](https://github.com/user-attachments/assets/3813b397-e9f6-46ec-bae5-3d3e9d334daa)

![image](https://github.com/user-attachments/assets/61306558-7251-454f-aad1-cbd489654292)

![image](https://github.com/user-attachments/assets/a46f551d-4da2-46df-9900-37e19f5479ce)

![image](https://github.com/user-attachments/assets/05ad7f99-ab0c-466b-a0bc-b2ff0d87adec)

![image](https://github.com/user-attachments/assets/654f460b-8688-4621-b9c8-a7ee4014594c)

Setup Windows10 Machine : 

![image](https://github.com/user-attachments/assets/73f24640-a0ea-4502-810e-2be1f42a128b)
![image](https://github.com/user-attachments/assets/c888c6bf-bbab-4dd4-bc07-75f6d46f84a9)
![image](https://github.com/user-attachments/assets/c1e8dce4-bbef-4d17-8e19-37d41caee25a)
![image](https://github.com/user-attachments/assets/824c4f64-6f14-4d2f-8efe-6a7a3fc36ee6)
![image](https://github.com/user-attachments/assets/098fe060-2658-44eb-861d-42abee5fd034)

![image](https://github.com/user-attachments/assets/da7b3ddc-25b7-476a-9519-066294409cb6)
![image](https://github.com/user-attachments/assets/1292e2ab-084a-44f7-8674-c2015ddde5df)

press any key 

![image](https://github.com/user-attachments/assets/5907e34a-72e2-4dcb-a514-a80300d758a7)

![image](https://github.com/user-attachments/assets/cd6e94c3-f5db-41b7-b1e7-53b1e78d4dcb)

![image](https://github.com/user-attachments/assets/54fc3bb4-61a9-4016-bd85-8713866f3a26)

Alright, we’ve encountered a problem here. Fortunately, the solution is simple.

While creating the virtual machine, we’ll make one small change:
Instead of attaching the **ISO file** during the machine setup process, we’ll **add the ISO after the machine has been created**.

![image](https://github.com/user-attachments/assets/13232ae9-c1c2-4407-8fb1-da8f85c8d669)

![image](https://github.com/user-attachments/assets/0472a3a9-22e6-4a08-9fde-f4f12dd92341)

![image](https://github.com/user-attachments/assets/d11abe1a-2517-4f75-9736-9f4af45f2269)

![image](https://github.com/user-attachments/assets/c6fd59f2-fd1f-4426-9d5e-8bd63d897aec)

![image](https://github.com/user-attachments/assets/6da8936d-67da-4596-a80f-62633f3503be)

![image](https://github.com/user-attachments/assets/9a980ab3-6617-4c7b-acc5-62d07b64f5bc)

![image](https://github.com/user-attachments/assets/2a3592a9-dc88-472d-af70-7ee83bc1c407)


![image](https://github.com/user-attachments/assets/26f76022-a58a-449e-babf-b9590882b1e7)

![image](https://github.com/user-attachments/assets/eddb56ba-5090-4353-ab64-9750c7bbed18)

![image](https://github.com/user-attachments/assets/78c27735-8adc-46b0-bb0c-e34afd543fe2)

![image](https://github.com/user-attachments/assets/2f158f01-a42b-459c-b195-90cb6c41d668)

(Windows Installation Options):

Explanation: This is a standard Windows Setup screen asking for the installation type.
- Upgrade: Installs Windows while keeping existing files, settings, and applications. Only available if a compatible Windows version is already running.
- Custom: Performs a clean installation of Windows, without migrating files or settings. This option is used for fresh installs or making changes to partitions.
Purpose: To choose between upgrading an existing Windows installation or performing a clean install.

![image](https://github.com/user-attachments/assets/dab45e57-e32f-4bda-b2a3-ac19887ad4c5)

![image](https://github.com/user-attachments/assets/078a1e10-bea8-48db-be51-894050b72dc9)

![image](https://github.com/user-attachments/assets/6c988cfe-71b6-479e-bd1f-e51e58d16b12)

![image](https://github.com/user-attachments/assets/029e94c5-a6b8-489b-9ab7-27e3481a9518)

![image](https://github.com/user-attachments/assets/1cd313da-8fac-4eb5-a699-cb4cd32e3a1d)

![image](https://github.com/user-attachments/assets/c5ecb574-beb9-4c0f-9779-de01b0c72309)

![image](https://github.com/user-attachments/assets/9af57ae0-27ad-4b75-9365-0e65409a15ac)


confirm password and complete next steps.

![image](https://github.com/user-attachments/assets/d6775131-7cc4-41ed-9691-e89a8ee63456)


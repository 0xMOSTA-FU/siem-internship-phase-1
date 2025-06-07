Hello my friends,
This is Mostafa Essam (0xMOST) with you. Today, in this file, we’ll start talking about the steps and everything we did to set up this lab.
I'm excited as I write this, so I hope you're just as excited!
Let’s get started.

>  **Important Note:**  
> I did **not** use a static IP address in my lab setup.  
> As a result, the IP address **changed every time** I shut down and restarted the system.  
> The only thing I updated was the IP **inside Winlogbeat** to match the new one each time.
> like that :

```
This is a local testing environment, so you’ll notice I’m a bit relaxed or implementing final ideas without following best practices, and I’m walking you through everything step by step.
But keep in mind—these things aren’t standard, so **don’t do them in a real production environment.**
```

![Screenshot 2025-05-13 003558](https://github.com/user-attachments/assets/34e1030d-80fd-4573-99ce-b8d9f361dcde)
![Screenshot 2025-05-14 162428](https://github.com/user-attachments/assets/e55b6fcb-18e7-4fee-9190-f6061c75a877)
![Screenshot 2025-05-15 053846](https://github.com/user-attachments/assets/58fdb6fd-c27e-4e1d-8964-d76a362e4c29)
![image](https://github.com/user-attachments/assets/3780bb75-281a-428a-b26f-6251965f18ba)


In the beginning, we’ll need to download software that allows us to run virtual machines, such as **VMware** or **VirtualBox**.
We’ll also need to download a **Windows 10** image, and we can get the ISO file from the official **Microsoft website**.

Additionally, we’ll download a Linux machine, whether it’s **Ubuntu**, **Parrot**, **Kali**, etc.


# Why did you choose Windows OS specifically for this lab?
As you Know, the most used Operating System (OS) worldwide is Microsoft Windows. Attackers know this, and every day, they develop new malware and techniques to target Microsoft Windows OS platforms. As a SOC analyst, you must understand the provided event logs by Microsoft in Windows environments that help you to investigate and detect cyber breaches.
### -ENG MOSTAFA YAHIA (Effective Threat Investigation for SOC Analysts Book).


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


Alright, we’ve finished setting up the machines we’ll be working on.

The next phase will be to **explain the technologies and tools** we’ll be using, along with the components we’ll be working with-in more detail.


# Logging & Logs
Logging is a fundamental aspect of modern software systems, serving as a critical tool for monitoring, debugging, auditing, and ensuring security. Here's an in-depth exploration of logging practices, structured to provide a comprehensive understanding.

![image](https://github.com/user-attachments/assets/6be3cc6b-8d33-44bc-9163-df73fc6a8a95)


---

### Understanding Logging: The Backbone of Observability

At its core, logging involves recording events that occur within a software system. These logs capture vital information such as timestamps, severity levels, messages, and contextual data. They are indispensable for diagnosing issues, understanding system behavior, and maintaining operational health.

---

### Structured Logging: Enhancing Clarity and Machine Readability

Traditional unstructured logs can be challenging to parse and analyze. Structured logging addresses this by formatting logs in a consistent, machine-readable manner, often using formats like JSON or key-value pairs. This approach facilitates easier parsing, searching, and integration with log analysis tools .

For instance, a structured log entry might look like:

```json
{
  "timestamp": "2025-05-31T14:00:00Z",
  "level": "INFO",
  "message": "User login successful",
  "user_id": "123456",
  "session_id": "abcde12345"
}
```

This format allows for efficient querying and analysis, enabling rapid identification of issues and trends.

---

### Log Levels: Categorizing the Significance of Events

Assigning appropriate severity levels to log messages is crucial for effective monitoring and alerting. Common log levels include:

* **FATAL**: Critical errors causing system shutdowns.
* **ERROR**: Significant issues requiring immediate attention.
* **WARN**: Potential problems that may not require immediate action.
* **INFO**: General operational messages indicating normal functioning.
* **DEBUG**: Detailed diagnostic information useful during development.
* **TRACE**: Fine-grained messages for in-depth troubleshooting .

Consistent use of these levels ensures that logs convey the right urgency and context, aiding in prioritization and response.

---

### Contextual Enrichment: Providing Comprehensive Insights

Enriching logs with contextual information—such as user IDs, session identifiers, request paths, and IP addresses—enhances their utility. This additional data enables more precise filtering, correlation, and analysis, especially in distributed systems where tracing the flow of a request across services is essential .

---

### Centralized Logging: Consolidating for Cohesive Analysis

In complex environments with multiple services and servers, centralized logging is vital. Aggregating logs into a unified system allows for holistic analysis, easier correlation of events, and streamlined troubleshooting. Tools like the ELK Stack (Elasticsearch, Logstash, Kibana), Fluentd, and Graylog facilitate centralized log management .

---

### Log Retention and Rotation: Balancing Accessibility and Resource Management

Implementing a log retention policy ensures that logs are stored for an appropriate duration, balancing the need for historical data with storage constraints. Regular log rotation prevents log files from becoming unwieldy, maintaining system performance and manageability .

---

### Security Considerations: Protecting Sensitive Information

Logs often contain sensitive data, making security a paramount concern. Best practices include:

* **Avoiding Logging of Sensitive Data**: Refrain from logging personal identifiers, passwords, or confidential information.
* **Access Controls**: Restrict log access to authorized personnel.
* **Encryption**: Secure logs both at rest and in transit to prevent unauthorized access.
* **Compliance**: Ensure logging practices adhere to regulations like GDPR or HIPAA .

---

### Real-Time Monitoring and Alerting: Proactive Issue Detection

Integrating real-time monitoring with logging systems enables immediate detection of anomalies and issues. Configuring alerts based on specific log patterns or severity levels ensures prompt response to critical events, minimizing downtime and impact .

---

### Choosing the Right Logging Framework: Aligning with System Requirements

Selecting an appropriate logging framework depends on factors like programming language, system architecture, and specific needs. Popular frameworks include:

* **Log4j 2**: Offers advanced features like asynchronous logging and support for various output formats .
* **Fluentd**: Facilitates data collection and unification across diverse sources .
* **SLF4J**: Provides a simple facade for various logging frameworks, promoting flexibility.

Evaluating these tools based on scalability, performance, and integration capabilities ensures alignment with organizational objectives.

---

### Documentation and Standardization: Ensuring Consistency and Clarity

Comprehensive documentation of logging practices—including log formats, severity level definitions, and retention policies—promotes consistency across teams and systems. Standardization simplifies onboarding, maintenance, and collaboration, enhancing overall efficiency .

---

### Conclusion

Effective logging is a cornerstone of robust software systems, enabling visibility, accountability, and resilience. By adopting structured logging, contextual enrichment, centralized management, and stringent security measures, organizations can harness the full potential of logs to drive informed decision-making and maintain operational excellence.

---


---

###  Logging: Capturing System Events

**Logging** is the process of recording events that occur within a system or application. These events can range from user actions and system errors to security breaches and performance metrics. Effective logging provides a chronological record that is invaluable for debugging, auditing, and understanding system behavior.

**Best Practices:**

* **Structured Logging:** Utilize formats like JSON or XML to ensure logs are machine-readable and easily parsable. Structured logs facilitate efficient searching and analysis .

* **Consistent Log Levels:** Implement standardized severity levels such as DEBUG, INFO, WARN, ERROR, and FATAL. This categorization aids in filtering and prioritizing log messages .

* **Descriptive Messages:** Craft clear and informative log messages that provide context, such as user IDs, transaction details, or error codes, to expedite troubleshooting.

* **Avoid Sensitive Data:** Refrain from logging personal identifiable information (PII) or confidential data to maintain compliance and security .

---

###  Log Management: Organizing and Analyzing Logs

**Log Management** encompasses the collection, storage, analysis, and disposal of log data. As systems generate vast amounts of logs, effective management ensures that relevant information is accessible and actionable.

![image](https://github.com/user-attachments/assets/1b1aa2aa-d87c-4e31-afb5-6d7639984d10)


**Best Practices:**

* **Centralized Logging:** Aggregate logs from various sources into a single repository using tools like the ELK Stack (Elasticsearch, Logstash, Kibana) or Splunk. This centralization simplifies analysis and enhances visibility .

* **Retention Policies:** Define how long logs should be stored based on regulatory requirements and business needs. Implement log rotation to manage storage and maintain performance .

* **Security Measures:** Protect log integrity by implementing access controls, encryption, and regular audits to prevent unauthorized access and tampering .

* **Regular Analysis:** Schedule periodic reviews of log data to identify trends, detect anomalies, and inform decision-making .

---

###  Monitoring: Real-Time System Oversight

**Monitoring** involves the continuous observation of system performance and health. It enables the detection of issues in real-time, allowing for prompt responses to potential problems.

![image](https://github.com/user-attachments/assets/f9701180-aef4-406e-a90b-f34e6092d58a)


![image](https://github.com/user-attachments/assets/0c6bbb09-7d63-42d0-a783-b88d4bf7cae9)

**Best Practices:**

* **Identify Key Metrics:** Determine critical indicators such as CPU usage, memory consumption, response times, and error rates to monitor system health .

* **Real-Time Alerts:** Configure alerts to notify relevant personnel when metrics exceed predefined thresholds, facilitating immediate action.

* **Dashboard Visualization:** Employ dashboards to present data visually, aiding in the quick assessment of system status.

* **Integration with CI/CD Pipelines:** Incorporate monitoring into continuous integration and deployment processes to assess the impact of changes on system performance.

---

###  Interplay Between Logging, Log Management, and Monitoring

These three components are interconnected:

* **Logging** provides the raw data.
* **Log Management** organizes and analyzes this data.
* **Monitoring** uses the insights derived to maintain system health.

Together, they form a comprehensive approach to system observability, enabling proactive maintenance, efficient troubleshooting, and informed decision-making.

---

###  What is Event Viewer?

**Event Viewer** is a built-in Windows utility that records detailed logs of significant events on your system. These events encompass system errors, application crashes, security incidents, and more. By accessing these logs, users can diagnose issues, monitor system health, and ensure security compliance. ([lenovo.com][1])

![Screenshot 2025-05-22 082305](https://github.com/user-attachments/assets/404a6773-2266-4e81-84d7-c99084da420b)

---

###  Types of Event Logs

Event Viewer categorizes logs into several sections:

* **Application Logs**: Events logged by applications or programs. For instance, a database application might log a file error.

* **System Logs**: Events logged by Windows system components, such as driver failures or system errors.

* **Security Logs**: Records of login attempts and resource access, crucial for auditing and identifying unauthorized access attempts.

* **Setup Logs**: Events related to application setups, including installations and updates.

* **Forwarded Events**: Logs collected from remote computers, useful in centralized monitoring scenarios.&#x20;

---

###  Event Levels Explained

Each event in the logs is assigned a level indicating its severity:([Windows Central][2])

* **Information**: General information about system operations.([lenovo.com][1])

* **Warning**: Indications of potential issues that aren't immediately critical.

* **Error**: Significant problems, such as loss of data or functionality.

* **Critical**: Severe issues causing complete failure of a component or system.

* **Audit Success/Failure**: Results of security access attempts, indicating whether they were successful or not.&#x20;

---

###  Accessing and Utilizing Event Viewer

To open Event Viewer:

1. Press `Windows + R`, type `eventvwr.msc`, and press Enter.

2. Navigate through the console tree to explore different logs.

Within Event Viewer, you can:

* **Filter Logs**: Narrow down events based on criteria like date, event level, or source.

* **Search Logs**: Find specific events using keywords or event IDs.

* **Create Custom Views**: Save specific filters for repeated use, streamlining the monitoring process.&#x20;

---

###  Practical Applications

Event Viewer serves multiple purposes:

* **Troubleshooting**: Identify the root causes of system crashes, application failures, or hardware issues.

* **Security Monitoring**: Detect unauthorized access attempts or changes to system settings.

* **Performance Analysis**: Monitor system performance and identify bottlenecks or recurring issues.

For instance, if your system experiences unexpected shutdowns, reviewing the System Logs can reveal if a specific driver or application is the culprit.([Windows Central][2])

---

By regularly reviewing and analyzing the logs within Event Viewer, users can maintain system integrity, preempt potential issues, and ensure a secure computing environment.

---
## Refrences and for more details Visit Links Below:

[1]: [https://www.lenovo.com/us/en/glossary/windows-event-viewer/?srsltid=AfmBOornhCQ-Fnxr8q41ZKmllxqBBGnQd61KgxXKS5kMf4vsNKjGd9FW&utm_source=chatgpt.com "What You Need to Know About Event Viewer in Windows 10 - Lenovo"]
[2]: [https://www.windowscentral.com/how-use-event-viewer-windows-10?utm_source=chatgpt.com "How to use Event Viewer on Windows 10"]

----

---

### What is Sysmon?

**Sysmon** is a Windows system service and device driver that logs system activity to the Windows event log. It provides detailed information about process creations, network connections, and changes to file creation time, among other activities. By collecting this data, Sysmon helps in detecting malicious activity and understanding system behavior. ([Tier Zero Security][1], [System Weakness][2], [blumira.com][3])

![image](https://github.com/user-attachments/assets/b90f9bba-ac78-43c4-9bb0-39f8299e805f)


---

###  Key Features of Sysmon

Sysmon captures a variety of system events, including:

* **Process Creation (Event ID 1)**: Logs details of newly created processes, including the process GUID, command line, and hashes of the executable.([System Weakness][2])

* **File Creation Time Changes (Event ID 2)**: Detects when a process changes the creation time of a file, which can be indicative of timestomping techniques used by malware.([defensiveorigins.com][4])

* **Network Connections (Event ID 3)**: Records TCP/UDP connections, providing information about source and destination IP addresses and ports.

* **Driver Loading (Event ID 6)**: Monitors when drivers are loaded into the system, which can help detect unauthorized or malicious drivers.([System Weakness][2])

* **Image Loading (Event ID 7)**: Tracks DLLs and other modules loaded into processes, useful for identifying code injection or DLL hijacking.([blumira.com][3])

* **Create Remote Thread (Event ID 8)**: Logs when a process creates a thread in another process, a technique often used in code injection.

* **Raw Disk Access (Event ID 9)**: Detects when a process reads data directly from a disk, bypassing the file system, which can be a sign of malicious activity.

* **Process Access (Event ID 10)**: Monitors when a process opens another process for access, which can indicate attempts to manipulate or inspect other processes.

* **File Creation (Event ID 11)**: Logs when a file is created, providing details about the process that created the file and the file's attributes.

These events provide granular visibility into system activities, aiding in threat detection and forensic investigations.&#x20;

---

###  Configuring Sysmon

Sysmon's behavior is governed by an XML configuration file, which specifies which events to log and under what conditions. Crafting an effective configuration is crucial to balance between comprehensive monitoring and manageable data volume.([cdn2.qualys.com][5])

Several community-driven configuration templates are available to help users get started:

* **SwiftOnSecurity's Sysmon Config**: A well-documented configuration file that provides high-quality event tracing and serves as a solid starting point for most environments. ([GitHub][6])

* **Olaf Hartong's Sysmon Modular**: Offers a modular approach to Sysmon configuration, allowing users to enable or disable specific monitoring features based on their needs.([GitHub][6])

These configurations can be customized to include or exclude specific processes, directories, or event types, tailoring Sysmon's monitoring to the organization's requirements.([learn.microsoft.com][7])

---

###  Getting Started with Sysmon

To install Sysmon, download it from the [Microsoft Sysinternals website](https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon) and run the following command in an elevated Command Prompt:([learn.microsoft.com][8])

```
Sysmon.exe -accepteula -i sysmonconfig.xml
```



This command accepts the license agreement and installs Sysmon with the specified configuration file.([Medium][9])

Once installed, Sysmon logs can be viewed in the Windows Event Viewer under:([manageengine.com][10])

```
Applications and Services Logs > Microsoft > Windows > Sysmon > Operational
```



Regularly reviewing these logs can help in identifying unusual or malicious activities on the system.

---

By integrating Sysmon into your system monitoring strategy, you gain detailed insights into system activities, enhancing your ability to detect and respond to security threats effectively.

---

## SIEM
Security Information and Event Management (SIEM) systems are integral to modern cybersecurity strategies, offering centralized visibility, real-time threat detection, and compliance reporting. A well-architected SIEM integrates various components to collect, analyze, and respond to security events effectively.

![image](https://github.com/user-attachments/assets/03d24cb7-9f29-4c4b-be23-574e8e6dc1be)


![image](https://github.com/user-attachments/assets/df365f13-29e0-43b1-8d64-c0d5d9e7159b)

---

###  Core Components of SIEM Architecture

1. **Data Collection and Aggregation**: SIEM systems gather log and event data from diverse sources such as servers, network devices, applications, and security tools. This can be achieved through agent-based methods, where agents installed on devices collect and forward logs; agentless methods, which rely on standard protocols like syslog; or API-based collection, especially useful for cloud services.

2. **Normalization and Parsing**: Collected data often comes in varied formats. Normalization transforms this data into a consistent structure, enabling efficient analysis. Parsing further breaks down the data into specific fields, facilitating detailed examination and correlation.

3. **Correlation Engine**: This component analyzes normalized data to identify patterns or relationships that may indicate security incidents. By correlating events across different sources, it helps in detecting complex threats that might go unnoticed in isolated logs.

4. **Alerting and Notification**: Upon detecting anomalies or threats, the SIEM system generates alerts to notify security personnel. These alerts can be prioritized based on severity, ensuring that critical issues are addressed promptly.

5. **Dashboards and Reporting**: SIEM solutions provide intuitive dashboards and reports that offer real-time insights into security events, aiding in quick decision-making and response. These tools help visualize data trends, monitor system health, and support compliance audits.

6. **Threat Intelligence Integration**: Incorporating external threat intelligence feeds allows the SIEM to stay updated on known threats, enhancing its detection capabilities. This integration aids in identifying indicators of compromise (IoCs) and understanding emerging attack vectors.

7. **Compliance Management**: SIEM systems assist organizations in meeting regulatory requirements by providing comprehensive reports and audit trails. They facilitate adherence to standards such as GDPR, HIPAA, and PCI DSS by ensuring proper log management and reporting.

8. **Data Storage and Retention**: Long-term storage of log data is essential for forensic investigations and compliance, ensuring that historical data is available when needed. SIEM solutions manage data retention policies to balance storage costs with regulatory obligations. 
---

###  Deployment Models and Best Practices

SIEM systems can be deployed on-premises, in the cloud, or as hybrid solutions. The choice depends on organizational needs, scalability requirements, and regulatory constraints. Best practices for SIEM implementation include:

* **Assessing Organizational Needs**: Understanding specific security requirements and compliance obligations is crucial for effective SIEM deployment.

* **Selecting Appropriate Deployment Models**: Choosing between on-premises, cloud-based, or hybrid SIEM solutions based on factors like scalability, cost, and data sovereignty.

* **Integrating with Existing Infrastructure**: Ensuring seamless integration with current security tools and IT systems to maximize the SIEM's effectiveness. 

* **Continuous Monitoring and Tuning**: Regularly updating correlation rules, refining alert thresholds, and monitoring system performance to adapt to evolving threats.

---

In summary, a well-structured SIEM architecture is integral to an organization's cybersecurity strategy, providing comprehensive visibility, proactive threat detection, and streamlined compliance management.

---

## ELK STACK IN Details (From Byte To SOC)

# **The Ultimate Deep Dive into ELK Stack: Architecture, Components, Communication, and Best Practices**

## **1. Introduction to ELK Stack**
The **ELK Stack** is a powerful, open-source log management and analytics platform that helps organizations collect, process, store, search, analyze, and visualize large volumes of data in real-time. It consists of four main components:

1. **Elasticsearch** – A distributed search and analytics engine that stores and indexes data.
2. **Logstash** – A data processing pipeline that ingests, transforms, and enriches logs before sending them to Elasticsearch.
3. **Kibana** – A visualization and dashboarding tool that allows users to explore and analyze data stored in Elasticsearch.
4. **Beats** – Lightweight data shippers that collect logs, metrics, and other data from various sources and send them to Logstash or Elasticsearch.

The ELK Stack is widely used for:
- **Log analysis** (security logs, application logs, system logs)
- **Security Information and Event Management (SIEM)**
- **Business intelligence & operational monitoring**
- **Infrastructure monitoring (servers, containers, cloud)**
- **Fraud detection & anomaly detection**

---

## **2. ELK Stack Architecture in Depth**
### **A. High-Level Architecture**
The ELK Stack follows a **pipeline-based architecture** where data flows in the following way:

1. **Data Collection (Beats or Logstash Forwarders)**  
   - **Beats** (Filebeat, Metricbeat, Packetbeat, etc.) collect logs, metrics, or network data from endpoints.
   - Alternatively, **Logstash can directly ingest logs** from files, syslog, databases, or APIs.

2. **Data Processing (Logstash)**  
   - Logstash applies **filters** (e.g., grok parsing, date formatting, field extraction, enrichment).
   - It can also **drop, modify, or route** logs based on conditions.

3. **Data Storage & Indexing (Elasticsearch)**  
   - Elasticsearch stores logs in **indices** (similar to database tables).
   - It provides **real-time search, aggregation, and analytics**.

4. **Data Visualization & Analysis (Kibana)**  
   - Kibana allows users to create **dashboards, visualizations, and alerts**.
   - SOC analysts use Kibana for **security log analysis, anomaly detection, and threat hunting**.

### **B. Detailed Data Flow**
#### **Scenario 1: Using Beats (Filebeat) → Logstash → Elasticsearch → Kibana**
1. **Filebeat** reads logs from `/var/log/syslog` and sends them to **Logstash** (port **5044**).
2. **Logstash** processes logs (e.g., extracts IPs, timestamps, error codes) and forwards them to **Elasticsearch** (port **9200**).
3. **Elasticsearch** indexes logs in an index named `logs-2023-10-01`, `logs-2024-10-01`, `logs-2025-10-01`.
4. **Kibana** (port **5601**) connects to Elasticsearch and visualizes logs in dashboards.

#### **Scenario 2: Direct Beats → Elasticsearch (No Logstash)**
- **Metricbeat** collects CPU/memory metrics and sends them directly to **Elasticsearch** (port **9200**).
- Kibana visualizes these metrics in real-time.

#### **Scenario 3: Logstash as the First Ingestion Point**
- Logstash listens on **TCP/UDP 514 (syslog)** or reads from **Kafka, RabbitMQ, or databases**.
- Useful when logs come from **network devices, firewalls, or legacy systems**.

---

## **3. Core Elasticsearch Concepts**
### **A. Node**
A **node** is a single instance of Elasticsearch running on a server. Nodes can have different roles:
- **Master Node** – Manages cluster state, shard allocation, and node discovery.
- **Data Node** – Stores and processes data (indices and shards).
- **Ingest Node** – Preprocesses documents before indexing (similar to Logstash).
- **Coordinating Node** – Routes requests and aggregates results (default role).

### **B. Cluster**
A **cluster** is a collection of **one or more nodes** working together.  
- Example: A **3-node cluster** (`node-1`, `node-2`, `node-3`) ensures **high availability**.
- If `node-1` fails, the remaining nodes keep the cluster running.

### **C. Index**
An **index** is like a **database table** in RDBMS.  
- Stores related documents (e.g., `web-logs-2025`, `firewall-logs`).
- Each index is split into **shards** (for scalability) and **replicas** (for fault tolerance).

### **D. Document**
A **document** is a **JSON record** stored in an index.  
- Example: A log entry in `web-logs-2025`:
  ```json
  {
    "timestamp": "2025-10-01T12:00:00Z",
    "source_ip": "192.168.1.1",
    "message": "Failed login attempt",
    "status": "ERROR"
  }
  ```

### **E. Shards & Replicas**
- **Shard**: A **subset of an index** (e.g., `web-logs-2025` has **5 shards**).
- **Replica**: A **copy of a shard** (for redundancy).  
- Example:  
  - Index: `web-logs-2025` (5 primary shards, 1 replica).  
  - Total shards = **5 primary + 5 replica = 10 shards**.

---

## **4. Communication & Ports in ELK Stack**
| Component | Default Port | Protocol | Purpose |
|-----------|-------------|----------|---------|
| **Elasticsearch** | 9200 (HTTP) | REST API | Client requests (Kibana, Logstash, Beats) |
| **Elasticsearch** | 9300 (TCP) | Transport | Internal node communication (cluster) |
| **Logstash (Beats Input)** | 5044 | TCP | Receives logs from Filebeat/Metricbeat |
| **Logstash (HTTP Input)** | 8080 | HTTP | Alternative input for REST APIs |
| **Kibana** | 5601 | HTTP | Web interface for visualization |
| **Beats (Filebeat, Metricbeat)** | N/A | Varies | Sends data to Logstash (5044) or Elasticsearch (9200) |

---

## **5. Common Issues & Troubleshooting**
### **A. High CPU/Memory Usage**
- **Cause**: Too many shards, inefficient queries, or heavy indexing.
- **Fix**:  
  - Limit **shard size** (30-50GB per shard).  
  - Optimize **Elasticsearch queries** (avoid wildcards).  
  - Increase **JVM heap size** (but not more than 50% of RAM).

### **B. Data Loss During Transmission**
- **Cause**: Logstash/Beats crashes before data is sent.
- **Fix**:  
  - Enable **persistent queues** in Logstash.  
  - Use **Filebeat’s registry file** to track sent logs.

### **C. Cluster Instability (Split Brain)**
- **Cause**: Network issues between master nodes.
- **Fix**:  
  - Set `discovery.zen.minimum_master_nodes = (N/2)+1` (where `N` = master-eligible nodes).  
  - Use **dedicated master nodes**.

### **D. Slow Search Performance**
- **Cause**: Too many indices, unoptimized mappings.
- **Fix**:  
  - Use **index lifecycle management (ILM)** to archive old logs.  
  - Define **proper mappings** (avoid `"type": "text"` for numeric fields).

---

## **6. Best Practices for ELK Stack**
### **A. Index Management**
- Use **Index Lifecycle Management (ILM)** to:
  - **Roll over** indices when they reach 50GB.
  - **Delete** old indices automatically (e.g., keep logs for 30 days).

### **B. Security Hardening**
- Enable **TLS encryption** between nodes.
- Use **role-based access control (RBAC)** via Elasticsearch Security.
- Restrict **Kibana dashboards** to authorized users.

### **C. Scaling & Performance**
- **Horizontal scaling**: Add more **data nodes** as data grows.
- **Separate roles**: Use **dedicated master, data, and ingest nodes**.
- **Monitor cluster health** with Elasticsearch’s `_cat` API or Kibana Monitoring.

### **D. Backup & Disaster Recovery**
- Use **snapshot & restore** to backup indices to **S3, GCS, or NFS**.
- Test **cluster recovery** in a staging environment.

---

## **7. ELK Stack for SOC Analysts**
### **A. Log Collection**
- **Filebeat**: Collects **system logs, auth logs, application logs**.
- **Packetbeat**: Monitors **network traffic** (useful for IDS/IPS).
- **Winlogbeat**: Captures **Windows Event Logs**.

### **B. Threat Detection**
- Use **Elasticsearch’s anomaly detection** for unusual login patterns.
- Create **Kibana dashboards** for:
  - **Failed login attempts**  
  - **Brute-force attacks**  
  - **Malware detection**  

### **C. Alerting**
- Set up **Watcher (Elasticsearch Alerting)** to trigger:
  - **Slack/Email alerts** for critical events.
  - **Automated responses** (e.g., block IP via firewall API).

### **D. Forensic Analysis**
- Use **Kibana Discover** to search logs with **KQL (Kibana Query Language)**.
- Correlate events with **Timelion** (time-series analysis).

---

The **ELK Stack** is a **versatile, scalable, and powerful** log management solution. Understanding its **architecture, data flow, and best practices** ensures optimal performance, security, and reliability. Whether you’re a **SOC analyst, DevOps engineer, or business analyst**, mastering ELK Stack will help you **unlock deep insights from your data**.

# **The Ultimate Low-Level Technical Deep Dive into ELK Stack & Beats**

## **1. Core Architecture: Packet-Level Analysis**

### **1.1 Elasticsearch Internals**
- **Shard Allocation Algorithm**: Uses a modified consistent hashing (CRUSH) algorithm to distribute shards across nodes. Each shard is a standalone Lucene index with its own:
  - Segment files (`.cfs`, `.si`, `.doc`)
  - Term dictionary (`.tim`)
  - Postings lists (`.doc`, `.pos`)
  - Norms (`.nvd`, `.nvm`)
  
- **Transaction Log (Translog)**: 
  - Binary write-ahead log (WAL) stored at `path.data/translog/`
  - Flushed to disk every `index.translog.sync_interval` (default 5s)
  - Segment merging triggers when `index.merge.policy.*` thresholds are met

### **1.2 Logstash Pipeline Mechanics**
- **Event Processing Stages**:
  1. **Input Queue**: In-memory (default) or persistent queue (when `queue.type: persisted`)
  2. **Filter Workers**: Thread pool size controlled by `pipeline.workers`
  3. **Output Batcher**: Uses bulk API with configurable `pipeline.batch.size`

- **Memory Management**:
  - JVM heap usage follows `LS_HEAP_SIZE` (default 1GB)
  - Native memory allocators (jemalloc vs system malloc) impact performance

### **1.3 Beats Protocol Details**
- **Lumberjack Protocol v2** (Filebeat to Logstash):
  - Frame format: `[2-byte version][4-byte sequence][4-byte payload length][payload]`
  - Window size configurable via `output.logstash.window_size`
  - Compression threshold at `output.logstash.compression_level`

- **Beats Persistent Registry**:
  - JSON file storing file offsets (e.g., `/var/lib/filebeat/registry/filebeat-*.json`)
  - CRC32 checksum validation for each recorded position

## **2. Data Processing: From Raw Bytes to Indexed Documents**

### **2.1 Logstash Filter Pipeline**
```ruby
filter {
  # Byte-level processing
  bytes { 
    field => "message"
    target => "message_bytes" 
  }
  
  # TCP/UDP packet dissection
  dissect {
    mapping => {
      "%{src_ip} %{dest_ip} %{protocol}" => "packet"
    }
  }

  # Low-level Grok pattern matching
  grok {
    match => { 
      "message" => [
        # Regex engine uses Oniguruma with Joni wrapper
        "(?<timestamp>%{DAY} %{MONTH} %{MONTHDAY} %{TIME} %{YEAR})",
        # Custom patterns load from `patterns_dir`
      ]
    }
  }
}
```

### **2.2 Elasticsearch Indexing Path**
1. **Document Routing**:
   - Hash formula: `routing_factor = hash(_routing) % number_of_primary_shards`
   - Custom routing via `?routing=user123`

2. **Lucene Indexing Process**:
   - Tokenization (StandardAnalyzer by default)
   - Inverted index construction
   - DocValues generation (for sorting/aggregations)
   - Segment file flushing (controlled by `refresh_interval`)

## **3. Network-Level Communication**

### **3.1 Elasticsearch Transport Protocol**
- **Binary Protocol** (port 9300):
  - Message format: `[4-byte length][1-byte status][payload]`
  - Compression with LZ4 when `transport.compress: true`
  - Thread pools:
    - `bulk` (size: `processors * 1.5`)
    - `search` (queue size: `thread_pool.search.queue_size`)

### **3.2 Beats to Logstash TLS Handshake**
```yaml
output.logstash:
  ssl:
    certificate_authorities: ["/etc/pki/ca.crt"]
    certificate: "/etc/pki/client.crt"
    key: "/etc/pki/client.key"
    verification_mode: "full"
    cipher_suites: [
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384"
    ]
    curve_types: ["secp384r1"]
```

## **4. File System Interactions**

### **4.1 Elasticsearch Storage Engine**
- **Directory Implementation**:
  - MMapDirectory (default on Linux)
  - NIOFSDirectory (Windows/fallback)
  - Direct I/O control via `index.store.preload`

- **Segment File Operations**:
  - `segments_N` generation during commit
  - `write.lock` contention handling
  - Fsync frequency controlled by `index.translog.durability`

### **4.2 Logstash File Input Monitoring**
```ruby
input {
  file {
    path => "/var/log/app/*.log"
    start_position => "beginning"
    sincedb_path => "/opt/logstash/sincedb"
    stat_interval => "1 second"
    discover_interval => 15
    file_completed_action => "delete"
    file_chunk_size => 32768  # 32KB read buffer
  }
}
```

## **5. Performance Optimization at Scale**

### **5.1 JVM-Level Tuning**
```conf
# Elasticsearch jvm.options
-XX:+UseG1GC
-XX:MaxGCPauseMillis=400
-XX:G1ReservePercent=25
-XX:InitiatingHeapOccupancyPercent=30
-XX:ParallelGCThreads=4
-XX:ConcGCThreads=2
```

### **5.2 Kernel Parameters**
```bash
# For optimal Elasticsearch performance
sysctl -w vm.max_map_count=262144
sysctl -w vm.swappiness=1
sysctl -w net.ipv4.tcp_retries2=5
ulimit -n 65536
```

## **6. Advanced Debugging Techniques**

### **6.1 Packet Captures**
```bash
# Capture Beats-Logstash communication
tcpdump -i eth0 'port 5044' -w beats_comm.pcap

# Analyze Elasticsearch transport protocol
tshark -d tcp.port==9300,elasticsearch -r transport.pcap
```

### **6.2 Hot Threads Analysis**
```json
GET /_nodes/hot_threads?threads=10&type=cpu&interval=500ms
{
  "ignore_idle_threads": false,
  "snapshot": true
}
```

## **7. Security Hardening**

### **7.1 Wire Encryption**
```yaml
# Elasticsearch node-to-node encryption
transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: certs/elastic-certificates.p12
```

### **7.2 Audit Logging**
```json
PUT /_cluster/settings
{
  "persistent": {
    "xpack.security.audit.enabled": true,
    "xpack.security.audit.logfile.events.include": "access_denied,anonymous_access_denied",
    "xpack.security.audit.logfile.events.exclude": "authentication_success"
  }
}
```



### **Elasticsearch Installation on Debian/Ubuntu**

This guide breaks down each step with technical depth, explaining **what happens at the system level** when installing Elasticsearch.

---

## **1. Adding the Elasticsearch GPG Key**
### **Command:**
```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
```
### **What This Does:**
1. **`wget -qO -`**  
   - Downloads the GPG key in quiet mode (`-q`) and outputs to stdout (`-O -`).  
   - The key is in **ASCII-armored format** (PEM-like structure).

2. **`gpg --dearmor`**  
   - Converts the ASCII-armored key into a **binary `.gpg` format** (stored in `/usr/share/keyrings/`).  
   - This binary file is used by `apt` to verify package signatures.

3. **Why?**  
   - Ensures packages are **authentic** (not tampered with).  
   - Without this, `apt` would reject Elasticsearch packages due to missing trust.

---

## **2. Configuring the APT Repository**
### **Command:**
```bash
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list
```
### **What This Does:**
1. **`deb [...]`**  
   - Defines a **Debian package repository** with:
     - `signed-by=` → Points to the GPG key for verification.  
     - `https://artifacts.elastic.co/packages/9.x/apt` → Official Elasticsearch repo.  
     - `stable main` → Uses the stable branch.

2. **`tee /etc/apt/sources.list.d/elastic-9.x.list`**  
   - Creates a **new `.list` file** in `/etc/apt/sources.list.d/`.  
   - Keeps Elasticsearch’s repo separate from system repos (cleaner than modifying `/etc/apt/sources.list`).

3. **Why Not `add-apt-repository`?**  
   - It modifies `/etc/apt/sources.list` directly (messes up system configs).  
   - Older versions add `deb-src` entries (which Elasticsearch doesn’t provide).  

---

## **3. Installing Elasticsearch**
### **Command:**
```bash
sudo apt update && sudo apt install elasticsearch
```

### **What Happens Under the Hood:**
1. **`apt update`**  
   - Fetches the latest package lists, including Elasticsearch’s repo.  
   - Validates packages using the GPG key (`Release.gpg` check).

2. **`apt install elasticsearch`**  
   - Downloads and installs:
     - **`elasticsearch`** (the main service).  
     - **Bundled OpenJDK** (in `/usr/share/elasticsearch/jdk/`).  
   - Sets up:
     - Systemd service (`/lib/systemd/system/elasticsearch.service`).  
     - Configs in `/etc/elasticsearch/`.  
     - Data directory (`/var/lib/elasticsearch/`).  

3. **Automatic Security Setup (First Run)**  
   - Generates:
     - **TLS certificates** (`/etc/elasticsearch/certs/`).  
     - **`elastic` user password** (logged in `/var/log/elasticsearch/`).  
   - Binds HTTP to `0.0.0.0` (accessible externally).  

![Screenshot 2025-05-14 200824](https://github.com/user-attachments/assets/53094bb1-04f9-427c-89da-0a13af163597)

---

## **4. Modifying `elasticsearch.yml`**
### **Key Configs Explained:**
```yaml
cluster.name: my-cluster  # Unique identifier for the cluster
network.host: 0.0.0.0    # Binds to all network interfaces
transport.host: 0.0.0.0  # Allows inter-node communication
```
### **What Changes at Runtime?**
- **`network.host`**  
  - Controls which **IPs Elasticsearch binds to**.  
  - `0.0.0.0` = Listen on all interfaces (dangerous in production unless firewalled).  
  - Default: `localhost` (only local access).  

- **`transport.host`**  
  - Used for **node-to-node communication** (cluster formation).  
  - If not set, nodes **can’t discover each other**.  

---

## **5. Starting Elasticsearch (Systemd)**
### **Commands:**
```bash
sudo systemctl enable elasticsearch  # Auto-start on boot
sudo systemctl start elasticsearch   # Starts the service
```
### **What Systemd Does:**
1. **Service File** (`/lib/systemd/system/elasticsearch.service`):
   - Defines:  
     - **ExecStart** → `/usr/share/elasticsearch/bin/systemd-entrypoint`  
     - **Environment** → `JAVA_HOME`, `ES_PATH_CONF`, etc.  
   - Runs as user `elasticsearch` (for security).  

2. **Logs** (`journalctl -u elasticsearch`):  
   - If startup fails, check **bootstrap checks** (e.g., `vm.max_map_count` too low).  

---

## **6. Validating the Installation**
### **Command:**
```bash
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:your_password https://localhost:9200
```
### **What’s Happening?**
1. **`--cacert`** → Uses the auto-generated CA cert (`http_ca.crt`) for HTTPS.  
2. **`-u elastic`** → Authenticates with the built-in superuser.  
3. Expected output:  
   ```json
   {
     "name" : "hostname",
     "cluster_name" : "my-cluster",
     "version" : { ... }
   }
   ```

---

## **7. Adding Nodes to a Cluster**
### **How Node Discovery Works:**
1. **First Node** generates a token:
   ```bash
   /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
   ```
   - This is a **JWT token** containing cluster credentials (valid 30 mins).  

2. **New Node** joins using:
   ```bash
   /usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token <token>
   ```
   - Modifies `/etc/elasticsearch/elasticsearch.yml` to add `discovery.seed_hosts`.  

3. **Under the Hood**:
   - Nodes communicate via **Zen2 discovery protocol** (over port `9300` by default).  
   - Elasticsearch uses **gossip protocol** to maintain cluster state.  

---

## **Key Low-Level Considerations**
1. **File Permissions**  
   - `/etc/elasticsearch/` → Owned by `root:elasticsearch`.  
   - `/var/lib/elasticsearch/` → Owned by `elasticsearch:elasticsearch`.  

2. **Memory Management**  
   - Elasticsearch **reserves 50% of RAM** for heap (adjust in `/etc/elasticsearch/jvm.options`).  

3. **Network Security**  
   - If using `0.0.0.0`, **enable a firewall** (`ufw` or `iptables`).  

---

### **Final Notes**
- This setup avoids **manual tarball installs** (which require handling Java, paths, and permissions manually).  
- The Debian package **automates security**, logging, and service management.  
- For **production**, further tuning is needed (e.g., separate data drives, dedicated `elasticsearch` user).  


---

### Manual Elasticsearch Installation (Debian/Ubuntu)

If you prefer downloading Elasticsearch directly rather than using the APT repository, here's how to do it properly:

First, we'll download both the Debian package and its checksum file from Elastic's official servers. This ensures we're getting authentic files. The commands:
```bash
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-9.0.0-amd64.deb
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-9.0.0-amd64.deb.sha512
```

Before installing, it's crucial to verify the package integrity. The SHA512 checksum acts like a digital fingerprint - we're making sure no one tampered with the file during download. Run:
```bash
shasum -a 512 -c elasticsearch-9.0.0-amd64.deb.sha512
```
You should see "OK" if the file is valid. If not, redownload it - something went wrong.

Now for the actual installation using dpkg:
```bash
sudo dpkg -i elasticsearch-9.0.0-amd64.deb
```
This command unpacks everything to the right places:
- The main program goes to /usr/share/elasticsearch
- Configuration files land in /etc/elasticsearch
- Data will be stored in /var/lib/elasticsearch

![Screenshot 2025-05-12 172109](https://github.com/user-attachments/assets/5685e362-b442-40e0-8548-cb2a0e59bdd6)



The installer automatically creates a dedicated 'elasticsearch' system user for security and sets up the systemd service. You can enable it to start on boot with:
```bash
sudo systemctl enable elasticsearch
```

After installation, you'll want to edit the config file:
```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```
At minimum, set your cluster name and network binding. For a development setup, you might use:
```yaml
cluster.name: my-dev-cluster
network.host: 0.0.0.0
```

Finally, start the service and verify it's working:
```bash
sudo systemctl start elasticsearch
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:your_password https://localhost:9200
```

The manual method gives you more control but requires extra steps compared to using APT. It's particularly useful for air-gapped systems or when you need to manage versions precisely. Just remember you'll need to manually download and verify future updates rather than using apt upgrade.


Now we move on to the common part, which is starting, preparation, setup, and adjusting the configuration files.

The common post-installation steps:

### **Common Post-Installation Steps (For Both Methods)**

```bash
# 1. Edit basic configuration
sudo nano /etc/elasticsearch/elasticsearch.yml
```
Add/modify these settings:
```yaml
cluster.name: my-cluster
network.host: 0.0.0.0
```

```bash
# 2. Restart the service
sudo systemctl restart elasticsearch

# 3. Verify it's running
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:your_password https://localhost:9200
```

### **Key Notes:**
1. The `elastic` user password is auto-generated on first install (check logs with `sudo journalctl -u elasticsearch`)
2. `network.host: 0.0.0.0` makes it accessible from other machines (use specific IP in production)
3. The curl command uses the auto-generated HTTPS certificate (`http_ca.crt`)

For production environments, you should also:
- Set proper firewall rules
- Configure proper memory limits in `/etc/elasticsearch/jvm.options`
- Change the default password immediately

# This is the link to the official documentation, so if you’re planning to work on the ELK Stack, I recommend visiting it, reading it, and understanding it well before proceeding. -------> [https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-with-debian-package]

### Pay attention—in the upcoming images, you’ll notice that I’m also setting up Kibana because I had downloaded it beforehand. However, I haven’t explained it yet in this article, specifically in this part. We’ll talk about it in the next plan, so stay tuned.

![449498113-1a01e21b-be9f-4641-abc2-27614948fb1f](https://github.com/user-attachments/assets/0ebe1cdf-4866-46fb-96c0-8ead84123741)

![449498127-fd365b16-336f-46fe-9842-67023dd47375](https://github.com/user-attachments/assets/aa2d31be-470c-4641-9132-77880caff477)

![449498253-5c520bf2-289b-4061-9d4d-67e1bd206e90](https://github.com/user-attachments/assets/aba15b7e-7d33-4485-a0f6-057a23cff8f4)

![449498321-b00e3dcc-5702-4c8f-b241-212bcd16e226](https://github.com/user-attachments/assets/caa8d1aa-c9df-4691-b33f-7f63b43bb219)

![449498356-45bdfe0f-4080-4736-93af-cb1e7b6b414d](https://github.com/user-attachments/assets/49709704-eb20-41a6-8612-691f6ee8c61e)

![449498443-8fffaffc-0f78-409b-ae09-0de8d1f56398](https://github.com/user-attachments/assets/5bbd7c8e-58cd-4b4f-88f5-941d4ae824b7)

![449498529-26f6102c-f1dc-4e05-906e-7f00caf03f46](https://github.com/user-attachments/assets/95914651-b01d-40b3-91ed-7aa609814c01)

![449498560-76633265-39ad-4ed4-9cb7-cf2ab0568963](https://github.com/user-attachments/assets/b1c9a34b-abad-499b-8f16-7f3c2a3c5aaa)

![449498586-2722475e-0eee-4d46-b2a9-168133fd6d95](https://github.com/user-attachments/assets/8fd4cb81-8e69-43aa-8666-8d30fb261fbd)

![449498606-d4ade5fc-2fc0-4da3-ae11-daea7ead8d7f](https://github.com/user-attachments/assets/7f20fa20-5499-43d8-b637-fc8bd5544472)

![449498615-f9d814cf-d718-400c-95be-4ab9372d0eff](https://github.com/user-attachments/assets/2d4edcf9-ec2e-4120-adc9-9da2e6eef2c2)

# This is the link to the official documentation, so if you’re planning to work on the ELK Stack, I recommend visiting it, reading it, and understanding it well before proceeding. -------> [https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-with-debian-package]

# Now, let’s talk about installing Kibana.

---

##  **Installing Kibana on Debian/Ubuntu Using the Debian Package**

Kibana can be installed on any Debian-based Linux distribution (like Debian or Ubuntu) using the official `.deb` package. The package includes both free and paid features — you can activate a 30-day trial to try all features.

---

###  **Step 1: Import Elastic PGP Signing Key**

Elastic signs its packages with a PGP key to ensure authenticity. You need to import this key before installing Kibana.

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
```

>  **Why?**
> This ensures your system can verify the authenticity of the package you're downloading and installing.

---

###  **Step 2: Install Kibana**

#### Option A: Install via APT Repository (Recommended)

1. **Ensure HTTPS support is available in APT:**

```bash
sudo apt-get install apt-transport-https
```

2. **Add Elastic’s APT repository:**

```bash
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list
```

3. **Update and install Kibana:**

```bash
sudo apt-get update && sudo apt-get install kibana
```

>  **Warnings**

* Do **not** use `add-apt-repository`. It may add a `deb-src` entry, which is not supported and can cause errors.
* Avoid duplicate repository entries to prevent `Duplicate sources.list entry` errors.

#### Option B: Manual Installation

1. **Download the `.deb` package:**

```bash
wget https://artifacts.elastic.co/downloads/kibana/kibana-9.0.0-amd64.deb
```

2. **(Optional) Verify file integrity:**

```bash
shasum -a 512 kibana-9.0.0-amd64.deb
```

3. **Install Kibana:**

```bash
sudo dpkg -i kibana-9.0.0-amd64.deb
```

---

###  **Step 3: Start Elasticsearch and Generate Enrollment Token**

Start your **Elasticsearch** instance first. On first run, it will:

* Create TLS certificates
* Set up `elasticsearch.yml`
* Set password for the `elastic` user
* Generate an **enrollment token** for Kibana

>  **If the token expires**, regenerate it:

```bash
bin/elasticsearch-create-enrollment-token -s kibana
```

---

###  **Step 4 (Optional): Make Kibana Accessible from Other Devices**

By default, Kibana listens only on `localhost`.

1. **Edit `/etc/kibana/kibana.yml`:**

```yaml
server.host: "0.0.0.0"
```

>  Use `0.0.0.0` to allow external access on any interface, or use a specific IP address for better security.

---

###  **Step 5: Manage Kibana with systemd**

Set Kibana to start on system boot:

```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
```

Start and stop the service manually:

```bash
sudo systemctl start kibana.service
sudo systemctl stop kibana.service
```

>  To check status:

```bash
sudo systemctl status kibana
```

>  To view logs:

```bash
journalctl -u kibana.service
```

---

###  **Step 6: Enroll Kibana with Elasticsearch**

1. Check Kibana status and look for the verification message:

```bash
sudo systemctl status kibana
```

You'll see something like:

```
Go to http://<host>:5601/?code=123456 to get started.
```

2. Open that link in your browser.
3. Enter the **enrollment token** you got earlier from Elasticsearch.
4. Click **Configure Elastic**.
5. When prompted, enter the 6-digit verification code from the status output.

Once setup completes:

* Use `elastic` as the username
* Use the password from Elasticsearch setup

---

###  **Step 7: Customize Kibana Configuration**

All Kibana settings are managed through:

```bash
/etc/kibana/kibana.yml
```

>  You can set things like Elasticsearch host, Kibana ports, logging options, and plugins here.

---

###  **Kibana Directory Structure in Debian Package**

| Component | Description                     | Path                        |
| --------- | ------------------------------- | --------------------------- |
| Home      | Kibana base directory           | `/usr/share/kibana`         |
| Binaries  | Start Kibana & install plugins  | `/usr/share/kibana/bin`     |
| Config    | Main config file (`kibana.yml`) | `/etc/kibana`               |
| Data      | Data storage for Kibana         | `/var/lib/kibana`           |
| Logs      | Log files                       | `/var/log/kibana`           |
| Plugins   | Installed plugins               | `/usr/share/kibana/plugins` |

---

![449498137-140bb613-3f57-4054-84b1-81a54065fa11](https://github.com/user-attachments/assets/b746490f-8df2-4f5c-8d2b-91ad6bde82f0)



manual: 

![449498178-eaf68aa3-88f5-41b0-8cec-83166d2afea1](https://github.com/user-attachments/assets/7fa617a8-5474-4cf5-a743-3b2fa3048900)

![449498207-150980f9-172c-429a-a8ca-6461a0a57f4c](https://github.com/user-attachments/assets/7e5cd6d5-cd88-4c6f-8bef-6d150d064ba7)

![449498229-298b7cfd-3b9d-40ea-bc3a-497c3c36aa67](https://github.com/user-attachments/assets/61ef3548-0fc8-47e4-aef8-c9f9af00ee51)

![449498253-5c520bf2-289b-4061-9d4d-67e1bd206e90](https://github.com/user-attachments/assets/8bd97b46-7001-4d90-bd23-211f72d5a59d)

![449498281-3b5c346f-7d62-49b3-8d2c-13e327e09c4b](https://github.com/user-attachments/assets/160ae527-9fdd-4b21-9c9a-49bc13e1bd3e)

![449498476-63eeeb69-2562-4e64-8d11-396e9f408d22](https://github.com/user-attachments/assets/ca9d71ea-7669-4725-a401-349f29a151fb)

![449498500-5c22199c-e68d-4b2b-9e98-59cb90c06117](https://github.com/user-attachments/assets/a67fd5e9-83ce-48a9-b1a4-931fe64b8c77)

![449498518-943856f3-d4f6-47cf-b6b9-d11e92e1fa4f](https://github.com/user-attachments/assets/5fb21166-0549-49ae-b5cd-cb0797f2d8f9)

![449498665-252793a7-ed17-46a8-98c8-ff822dd37d9c](https://github.com/user-attachments/assets/da2ffe12-9694-421f-a0dc-8ebb8fa539aa)

------
### Now that we’ve downloaded Elasticsearch and Kibana and modified the settings and since we’ve already explained everything related to downloading and configuration let’s now connect these two components together: Elasticsearch and Kibana.
------
We will create a token and place it in Kibana, Using the following command:
```bash

[mosta@parrot] -[~]
$ sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node

```
![449498701-1102688a-66bf-44d9-b054-1f2f485b0c62](https://github.com/user-attachments/assets/6c3fd646-c227-42c9-9a5e-46cf1b6c116c)

place it in Kibana:

![449498718-28be2727-02ff-4aa5-abf1-0749a928ad4f](https://github.com/user-attachments/assets/ffa87129-f40a-4892-90db-3fb5cbf91aed)


Alright, now we’ll need to get the Verification code that was sent to us after entering the token in order to complete the process and initialization.

![449498735-310c131e-492d-4e8b-8cd0-539989739224](https://github.com/user-attachments/assets/cd43f1b6-3ec5-4b24-8a2f-a15915fc4fab)

We can get the verification code using this command:

```bash
[x]-[mosta@parrot]-[~]
  - $sudo journalctl -u kibana.service | grep "verification code"
```

### Explanation:

* `sudo`: Runs the command with administrator (root) privileges.
* `journalctl -u kibana.service`: Shows logs specifically for the Kibana service.
* `| grep "verification code"`: Filters the logs to show only lines that contain the phrase **"verification code"**.

### What it does:

It shows you the **Kibana verification code**, which is usually generated the **first time you start Kibana**. This code is required to complete the initial setup or login.

![449498745-00f7779b-dfee-4d7c-8d5c-075983fa470f](https://github.com/user-attachments/assets/54f53002-dbf1-4f3f-96ab-27e6c724926e)

![449498769-49e9d28c-936f-41da-abaa-7b97d851333a](https://github.com/user-attachments/assets/2d193c73-bc62-4cf7-85a7-8a37c2efcda7)

![449498799-422602a4-9e55-4551-bc45-bbc1cff1bdc5](https://github.com/user-attachments/assets/943bc0b2-64fb-4847-9b57-9a5ec12a45fc)

![449498851-b0cda5ce-ce3d-4bc9-9572-d02834ccb23b](https://github.com/user-attachments/assets/b3ab06bc-1479-4633-ad23-5b417c159312)

![449498914-872e5051-3344-42b4-92c1-2b89d3c5d74b](https://github.com/user-attachments/assets/8e7b60d9-4e13-4dcf-ad86-545110f850d7)

![449498948-1b053848-e72e-4e2f-9e5d-58c516863cd9](https://github.com/user-attachments/assets/7b0e79c9-31f6-48e7-af01-a664c144f525)

![449499050-9dc13ce7-504a-4346-a209-22cdf3e6c606](https://github.com/user-attachments/assets/409253a3-6fb8-4af7-9064-c27ed0207fb7)


Now, let’s download Winlogbeat and Sysmon on our log source device, which is the designated target in this lab currently running Microsoft Windows 10.  Let’s go ahead and start explaining the download steps right away. Previously, we’ve already covered a detailed explanation of Sysmon, the concept of logs, Winlogbeat, and also Event Viewer. 


---

## **Quick Start Guide: Installing and Configuring Winlogbeat**

This step-by-step guide walks you through the process of setting up **Winlogbeat** for monitoring Windows event logs. It covers everything from installation to visualization using the **Elastic Stack**. By the end of this guide, you'll know how to:

* Install Winlogbeat on any Windows system you want to monitor
* Define which logs you want to collect
* Send log data to **Elasticsearch** for indexing
* Use **Kibana** to visualize and explore your log data using dashboards

![image](https://github.com/user-attachments/assets/8a3ccb39-bfdc-4bad-a802-f07f69e2f7b4)

---

### **Prerequisites**

To get started, you must have:

* An **Elasticsearch instance** (used to store and search the logs)
* **Kibana** (used to visualize and manage the collected data)

You can choose between:

####  **Elastic Cloud (Hosted Solution)**

A quick way to deploy the Elastic Stack ((Elastic Cloud Hosted)[https://www.elastic.co/cloud?page=docs&placement=docs-body]) using a managed service on platforms like **AWS**, **Google Cloud**, or **Azure**. It’s ideal for getting started without setting up infrastructure. Free trial available[https://cloud.elastic.co/registration?page=docs&placement=docs-body].

####  **Self-Managed Deployment**

If you prefer to install and manage everything yourself, you can set up Elasticsearch and Kibana locally or on your own servers.

---

### **Step 1: Install Winlogbeat**

1. Download the Winlogbeat `.zip` file from the [Elastic downloads page](https://www.elastic.co/downloads/beats/winlogbeat).
2. Extract the contents to:
   `C:\Program Files`
3. Rename the extracted folder to:
   `Winlogbeat`
4. Open **PowerShell** as Administrator (Right-click → Run as Administrator)
5. Navigate to the Winlogbeat directory and install the service:

```powershell
cd 'C:\Program Files\Winlogbeat'
.\install-service-winlogbeat.ps1
```

>  **Security Warning:**
> PowerShell may prompt you with a warning about running the script. If you trust the script source, you can unblock it using:
> `Unblock-File .\install-service-winlogbeat.ps1`

If script execution is disabled, allow it for this session using:

```powershell
PowerShell.exe -ExecutionPolicy UnRestricted -File .\install-service-winlogbeat.ps1
```

---

### **Step 2: Connect Winlogbeat to the Elastic Stack**

To send logs to Elasticsearch and load dashboards into Kibana, configure the connection settings in the `winlogbeat.yml` file.

### For Elastic Cloud Users:

Add the following configuration:

```yaml
cloud.id: "your_cloud_id"
cloud.auth: "username:password"
```

ex :
```yaml
cloud.id: "staging:dXMtZWFzdC0xLmF3cy5mb3VuZC5pbyRjZWM2ZjI2MWE3NGJmMjRjZTMzYmI4ODExYjg0Mjk0ZiRjNmMyY2E2ZDA0MjI0OWFmMGNjN2Q3YTllOTYyNTc0Mw=="
cloud.auth: "winlogbeat_setup:YOUR_PASSWORD"
```
Note: It’s best to store passwords securely using the **Elastic Keystore** rather than writing them directly in the file.

### For Self-Managed Users:

---

### **Winlogbeat Configuration for Elasticsearch and Kibana**

####  **1. Configure Elasticsearch Connection**

You need to define the **host and port** where Winlogbeat can reach your Elasticsearch instance. Additionally, specify the **username and password** of a user who has the necessary permissions to configure and use Winlogbeat.

```yaml
output.elasticsearch:
  hosts: ["https://myEShost:9200"]
  username: "winlogbeat_internal"
  password: "YOUR_PASSWORD"
  ssl:
    enabled: true
    ca_trusted_fingerprint: "b9a10bbe64ee9826abeda6546fc988c8bf798b41957c33d05db736716513dc9c"
```

>  **Note:**
>
> * The password shown above is hard-coded for demonstration purposes. In production, it's best practice to store sensitive credentials securely in the **Elasticsearch secrets keystore**.
> * Similarly, the `ca_trusted_fingerprint` is hard-coded here but should also be managed securely.

#####  About the `ca_trusted_fingerprint`:

This is a **SHA-256 hexadecimal fingerprint** of a **Certificate Authority (CA) certificate**. It is used by Winlogbeat to **verify the identity of the Elasticsearch server** and establish a trusted, encrypted connection.

When Elasticsearch starts for the first time, it automatically enables **security features**, including **TLS encryption** (Transport Layer Security). If you're using the **default self-signed certificate** generated by Elasticsearch on first startup, you'll need to supply its fingerprint here.

* The fingerprint is typically displayed in the **Elasticsearch startup logs**.
* You can also consult the [Elastic documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-tls.html) for other ways to retrieve it.
* If you're using your **own SSL certificate**, refer to the [Winlogbeat documentation](https://www.elastic.co/docs/reference/beats/winlogbeat/configuration-ssl#ssl-client-config) for steps to configure SSL accordingly.

[Automatic security setup](https://www.elastic.co/docs/deploy-manage/security/self-auto-setup)

[Secrets keystore for secure settings](https://www.elastic.co/docs/reference/beats/winlogbeat/keystore)

---

####  **2. Configure Kibana Endpoint (Optional)**

If you intend to use Winlogbeat's **pre-built dashboards** in Kibana, you'll need to specify the Kibana server address and, optionally, login credentials.

```yaml
setup.kibana:
  host: "mykibanahost:5601"
  username: "my_kibana_user"
  password: "YOUR_PASSWORD"
```

#####  Key Points:

* `host`: Indicates the **Kibana server address and port**. Example: `mykibanahost:5601`.
  If Kibana is served on a specific path, you must include the full URL with protocol and port, such as:
  `http://mykibanahost:5601/custom/path`.

* `username` and `password`: These are **optional**. If not specified, Winlogbeat will reuse the **Elasticsearch output credentials**.

>  To use the dashboards, the Kibana user must have permissions to view and manage dashboards. The user should ideally have the `kibana_admin` built-in role or equivalent custom privileges.

---

####  **Additional Notes:**

* Always follow best practices by storing secrets and sensitive credentials securely via the **secrets keystore** rather than exposing them in plaintext configuration files.
* For more information on required roles and access control, refer to the [official guide on securing access](https://www.elastic.co/docs/reference/elasticsearch/roles).

---

Refer to the documentation to assign the correct roles and privileges to the Winlogbeat user.

---
### **Configuring Elasticsearch and Kibana for Winlogbeat**

To enable Winlogbeat to send data to your **Elasticsearch** cluster and set up dashboards in **Kibana**, you need to configure the appropriate output and setup sections in the `winlogbeat.yml` configuration file.

---

### **1. Configure Elasticsearch Output**

Specify the **host and port** of your Elasticsearch node, as well as the **username and password** of a user who has the necessary privileges to publish events and set up Winlogbeat assets (like index templates and ingest pipelines).

```yaml
output.elasticsearch:
  hosts: ["https://myEShost:9200"]
  username: "winlogbeat_internal"
  password: "YOUR_PASSWORD"
  ssl:
    enabled: true
    ca_trusted_fingerprint: "b9a10bbe64ee9826abeda6546fc988c8bf798b41957c33d05db736716513dc9c"
```

####  **Important Notes on Security Settings:**

* **Hard-coded credentials** (like `password`) are used here for simplicity, but it is highly recommended to store sensitive information securely using the **Elasticsearch keystore** instead of putting them directly in the config file.

* The `ca_trusted_fingerprint` is a **SHA-256 fingerprint** of the **Certificate Authority (CA)** certificate used by Elasticsearch for TLS encryption. This is a **hexadecimal-encoded** string that allows Winlogbeat to verify the identity of the Elasticsearch server and establish a secure connection.

####  **About TLS in Elasticsearch:**

When Elasticsearch is run for the first time, it generates a **self-signed certificate** and **enables security features by default**, including encryption via TLS. If you're using this default setup, you'll need to copy the **CA fingerprint** from the Elasticsearch logs during startup.

> For alternative methods of retrieving the fingerprint or if you're using your own custom SSL certificate, refer to the [Elastic documentation on secure client connections](https://www.elastic.co/guide/en/beats/winlogbeat/current/configuring-ssl.html).

---

### **2. Configure Kibana Access (Optional but Recommended)**

If you plan to load the **pre-built dashboards** provided by Winlogbeat into **Kibana**, you must configure the Kibana endpoint. This step can be skipped if Kibana is running on the same machine and uses default settings, but it’s best practice to define it explicitly.

```yaml
setup.kibana:
  host: "mykibanahost:5601"
  username: "my_kibana_user"
  password: "YOUR_PASSWORD"
```

####  **Explanation of Fields:**

* `host`: This is the **hostname and port** where Kibana is accessible. For example:

  * Basic: `mykibanahost:5601`
  * With path: `http://mykibanahost:5601/custom/path`

* `username` and `password`: These credentials are **optional**. If not specified, Winlogbeat will reuse the **Elasticsearch output credentials**. However, if you provide different credentials here, ensure that the user has permission to **load dashboards and access Kibana features**.

>  The user assigned for Kibana setup should have the `kibana_admin` built-in role or equivalent permissions.

---

###  Summary

| Section                | What to Configure                    | Why                                                      |
| ---------------------- | ------------------------------------ | -------------------------------------------------------- |
| `output.elasticsearch` | Host, user, password, CA fingerprint | Allows Winlogbeat to send logs securely to Elasticsearch |
| `setup.kibana`         | Host, (optional) credentials         | Loads dashboards and visualizations into Kibana          |

---

### **Step 3: Configure the Logs to Monitor**

Edit the `winlogbeat.yml` file to specify which Windows event logs should be collected. By default, it monitors:

```yaml
winlogbeat.event_logs:
  - name: Application
  - name: Security
  - name: System
```

To list all available logs on your system, run:

```powershell
Get-EventLog -List
```

#### Optional: Enable Logging for Winlogbeat Itself

```yaml
logging.to_files: true
logging.files:
  path: C:\ProgramData\winlogbeat\Logs
logging.level: info
```

After updating the configuration, test it with:

```powershell
.\winlogbeat.exe test config -c .\winlogbeat.yml -e
```

---

### **Step 4: Load Default Assets**

Winlogbeat provides built-in assets for easier setup:

* Index templates (for proper data mapping in Elasticsearch)
* Ingest pipelines (to process the log data)
* Kibana dashboards (to visualize logs)

Load these assets by running:

```powershell
.\winlogbeat.exe setup -e
```

>  **Note:** You must have a valid connection to Elasticsearch for this step. If you're using Logstash instead, refer to the documentation for manual asset loading.

---

### **Step 5: Start the Winlogbeat Service**

Make sure your credentials in `winlogbeat.yml` allow publishing events.

Start the service:

```powershell
Start-Service winlogbeat
```

Verify the service is running via:

```powershell
services.msc
```

Logs will be available at:

```
C:\ProgramData\winlogbeat\Logs\winlogbeat
```

---

### **Step 6: View Logs in Kibana**

After setup, open Kibana to view dashboards:

#### For Elastic Cloud:

* Log into your Elastic Cloud account
* Navigate to the Kibana endpoint

#### For Self-Managed Users:

Point your browser to http://localhost:5601, replacing localhost with the name of the Kibana host.

* Open Kibana in your browser
* Go to **Discover** and make sure the `winlogbeat-*` index pattern is selected
* Use **Dashboard** to explore pre-built visualizations

>  **Tip:** If no data is visible, increase the time filter to a longer range (e.g., last 24 hours)

---

### **Optional: Run Winlogbeat with a Local (Non-Admin) Account**

By default, Winlogbeat runs as the **Local System** account. If you want it to run under a **local user account** without admin privileges:

1. Open Services Console:

   ```powershell
   services.msc
   ```

2. Right-click `winlogbeat` → **Properties** → **Log On** tab
   Choose “This account”, browse for your local user, and enter its password.

3. Open Local Group Policy Editor:

   ```powershell
   gpedit.msc
   ```

   Go to:
   `Computer Configuration > Windows Settings > Security Settings > Local Policies > User Rights Assignment`

   Add the local user to:

   * **Log on as a service**

4. Open Local Users and Groups:

   ```powershell
   lusrmgr.msc
   ```

   Add the user to the group:

   * **Event Log Readers**

This grants the user the permissions necessary to run Winlogbeat and read event logs.

---

###  Summary

| Step | Action                                 |
| ---- | -------------------------------------- |
| 1    | Download and install Winlogbeat        |
| 2    | Connect it to Elasticsearch and Kibana |
| 3    | Configure the logs to monitor          |
| 4    | Load default dashboards and pipelines  |
| 5    | Start the Winlogbeat service           |
| 6    | View logs in Kibana dashboards         |

---

# [Don’t forget to check the official documentation for more information.](https://www.elastic.co/docs/reference/beats/winlogbeat/winlogbeat-installation-configuration)

------

>  **Important Note**
> 
> Throughout this lab, my environment experienced **frequent IP changes**, which caused instability and led to the use of **different IP addresses** across various sections.
> 
>  Recently, the IPs have stabilized within the following range:
> `192.168.1.x/24`
> 
> As a result, you may notice multiple IPs referenced during the lab exercises.  
> I also **modified the Winlogbeat and ELK Stack configurations** several times to adapt to the ongoing IP changes and maintain proper functionality.

![Screenshot 2025-05-14 152307](https://github.com/user-attachments/assets/42be40f2-8451-4c26-8006-a584a9be357a)

![Screenshot 2025-05-14 153312](https://github.com/user-attachments/assets/52d2e4a5-763b-4bdd-a07f-22956e9e5f4b)

![Screenshot 2025-05-14 153601](https://github.com/user-attachments/assets/33c6991c-fa11-4dd0-a945-01bcd0a6b40c)

![Screenshot 2025-05-14 153620](https://github.com/user-attachments/assets/a6b6c8fe-3f16-4f9f-8100-c0203b598ddc)

![Screenshot 2025-05-14 153758](https://github.com/user-attachments/assets/aedecf16-b949-4fef-9157-713b526cdd77)

## Alright, if you need to transfer the certification, you can use drag and drop, or you can transfer it by setting up a local web server as shown below.

![Screenshot 2025-05-14 162428](https://github.com/user-attachments/assets/7e40171e-2318-43f4-a3b7-f8fc1e8ec10b)

![Screenshot 2025-05-14 162635](https://github.com/user-attachments/assets/cf6c6dc5-994f-45fe-9d77-99d069460f5a)

![Screenshot 2025-05-14 162656](https://github.com/user-attachments/assets/1e261c00-e0bb-459a-891a-63e5a1dabd46)

![Screenshot 2025-05-14 163007](https://github.com/user-attachments/assets/18ae9312-a1ed-4194-8b81-a898a3089510)

![Screenshot 2025-05-14 163129](https://github.com/user-attachments/assets/fe612239-4351-47d4-a688-45c68f21fb95)

![Screenshot 2025-05-14 163831](https://github.com/user-attachments/assets/cb31efad-6d5c-4c3d-a4cf-3023a9e87ed0)

# Alright, I chose to disable SSL certificate verification. This is just a testing environment—but to be clear, this should **not** be done in a real setup.
```
 #ssl.certificate_authorities: [...]
This line is commented out (disabled) using #.

If enabled, it would tell Winlogbeat to verify the SSL certificate of the Elasticsearch server using the provided .crt file path.

Since it's commented, Winlogbeat is not verifying the server certificate.

 ssl.verification_mode: none
This means SSL certificate verification is turned off, so Winlogbeat will connect to the server even if the SSL certificate is untrusted or self-signed.

 Security Risk: This is unsafe for production environments. It's only acceptable for local testing or development setups.
```
![Screenshot 2025-05-15 055724](https://github.com/user-attachments/assets/1036f5c0-3efb-41a5-962b-b0aac0b683dd)

```
This is a local testing environment, so you’ll notice I’m a bit relaxed or implementing final ideas without following best practices, and I’m walking you through everything step by step.
But keep in mind—these things aren’t standard, so **don’t do them in a real production environment.**
```

# Now we’ll start by creating the index, sending the logs, and viewing the results in Kibana.

![Screenshot 2025-05-15 061741](https://github.com/user-attachments/assets/5eee2115-8f5c-491a-92fd-808c32a938c4)

![Screenshot 2025-05-15 061801](https://github.com/user-attachments/assets/514d9e80-826c-4e17-ac53-57d71049fd63)

### Create Data View

---
###  Step-by-Step Instructions:

1. **Open Kibana**
   Go to Kibana in your browser (usually something like: `http://localhost:5601` or your server address).

2. From the **left sidebar**:
   Click on **"Management"**.
   In newer versions, it might be listed as **"Stack Management"**.

3. Inside the Management section:
   Click on **"Data Views"**.
   In older versions of Kibana, it might be labeled as **"Index Patterns"**.

4. On the Data Views page:

   * Click **"Create data view"** (or “Create index pattern” if it's an older version).

5. On the creation form:

   * **Data view name**: Enter a name for the view (this is what you’ll see inside Kibana).
   * **Index pattern**: Type the name of your index or a wildcard pattern (e.g., `logs-*`, `myindex-*`).
   * If the index exists, it will show a message like: “Your data view matches X indices.”

6. (Optional) If your index contains a timestamp field (like `@timestamp`):

   * Select it in the **"Timestamp field"** dropdown to enable time-based filtering.

7. Finally:

   * Click **"Create data view"**.

---

###  Now you can use this Data View in:

* **Discover** (to explore raw data)
* **Visualizations / Dashboards**
* **Lens, Alerts, and more**

---


![Screenshot 2025-05-15 061831](https://github.com/user-attachments/assets/1a0e228e-d263-456a-8d10-a3ce40a3c39d)

![Screenshot 2025-05-15 061838](https://github.com/user-attachments/assets/75ceedd3-8251-45e5-aec6-e54649c9ff06)

![Screenshot 2025-05-15 061947](https://github.com/user-attachments/assets/ad88d686-45e6-43bc-8a9a-ebb3b2d32768)

![Screenshot 2025-05-15 061952](https://github.com/user-attachments/assets/b67b38b1-d68e-4491-82f6-582f25ce2d99)

![Screenshot 2025-05-15 062614](https://github.com/user-attachments/assets/abcd81c7-f6b0-42c3-8230-626f72696e50)

![Screenshot 2025-05-15 062627](https://github.com/user-attachments/assets/6787581e-c132-48a7-aae2-43dcbb319b22)

![Screenshot 2025-05-15 062733](https://github.com/user-attachments/assets/4ea48505-2b16-4bf3-8166-e1df3930537c)

![Screenshot 2025-05-15 063102](https://github.com/user-attachments/assets/4d37cc27-c3a8-4838-9663-a1ecb2dddf03)

![Screenshot 2025-05-15 063856](https://github.com/user-attachments/assets/ca608472-c28f-4641-bee2-72564674baa8)

# Let's go ahead and configure some rules.

> You can visit the other sections of the repo, where you’ll find details of all the rules, as well as some final notes and summaries explaining certain parts.
>
> Also, keep following along here—there are some important details coming up.

You can visit the other sections of the repo, where you’ll find details of all the rules, as well as some final notes and summaries explaining certain parts.

Also, keep following along here there are some important details coming up.

![Screenshot 2025-05-18 023647](https://github.com/user-attachments/assets/3d3f3c9c-c9b1-4c46-8556-e0fac041759f)

The error message you’re seeing is:

> **Error fetching rule migrations**
> **Bad Request**
> `Error: Bad Request`
> with a URL pointing to:

```
http://192.168.27.224:5601/504d6bfa94cc/bundles/core/core.entry.js
```

### What it means:

This error is coming from **Kibana**, and it indicates that something went wrong when trying to **fetch or migrate security detection rules** (SIEM rules). The HTTP status **"Bad Request" (400)** means the request sent to the server is malformed or invalid.

---

### Possible causes:

1. **Version mismatch between Kibana and Elasticsearch**
   – For example, using Kibana 9.0 with Elasticsearch 8.x without proper compatibility settings.

2. **The API endpoint is not enabled or supported**
   – The "Rule Migration" feature might be disabled or not supported in your current deployment.

3. **Insufficient permissions**
   – Your user might lack required roles (e.g., `manage_security`, `manage_rules`, or superuser).

4. **Corrupt plugin or bundle**
   – There might be an issue with the JavaScript files Kibana is using, like caching errors or corrupted bundles.

5. **Reverse proxy interference**
   – If you're using Nginx or another proxy in front of Kibana, it may be modifying the request incorrectly.

---

### How to fix it:

1. **Check version compatibility**
   – Make sure Kibana and Elasticsearch are running matching versions (e.g., both 9.0).

2. **Check Kibana server logs**
   – Look for logs around the same timestamp in `kibana.log` to get the real backend error.

3. **Try with a user with full permissions**
   – If you’re using a limited user, switch to one with `superuser` rights.

4. **Clear browser cache and refresh Kibana**
   – Sometimes browser cache or bad JS bundles can cause these errors.

5. **Verify SIEM and Rule Management features are enabled**
   – Check your `kibana.yml` config to ensure nothing is disabled.

6. **Test API directly using Postman or cURL**
   – To isolate whether it’s a front-end problem or backend/API issue.


![Screenshot 2025-05-18 023949](https://github.com/user-attachments/assets/020cc881-ec97-4a80-b164-b564009f9fa0)

 how to **navigate to the Detection Rule creation page in Kibana (Elastic Security)** :

---

##  How to Access the Detection Rules Section:

### 1. **Open Kibana**

Go to your browser and open Kibana (usually something like `http://localhost:5601` or your server’s IP).

---

### 2. **Go to the "Security" app**

From the left sidebar, click on **"Security"**.

---

### 3. **Click on "Rules"**

Inside the Security section, click **Rules** (you’ll see it under Dashboards and Alerts).

---

### 4. **Click "Create Rule"**

Now on the top-right or middle, you’ll find a button called **“Create Rule”** or **“+ Create new rule”**. Click that.

---

### 5. **You’re on the Rule Creation Page**

Now you’ll see a screen where you can choose the **Rule type**:

* **Custom query** → Write your own KQL/Lucene condition.
* **Threshold** → Trigger alert when something happens X times.
* **Machine Learning** → Use ML jobs to detect anomalies.
* And more...

---

##  What do you do on this page?

1. **Pick a Rule Type** (e.g. "Custom Query").
2. **Fill in the detection conditions** (query, indices, schedule, actions).
3. **Click “Create & Enable”** to activate the rule.

---

```bash
sudo nano /etc/kibana/kibana.yml
```

and add this:

![Screenshot 2025-05-18 025528](https://github.com/user-attachments/assets/315f9fa8-609e-4df8-85d1-db4a396564f0)

![Screenshot 2025-05-18 025539](https://github.com/user-attachments/assets/29854861-20b5-421e-a0b6-5a24dc8f08da)

![Screenshot 2025-05-18 025548](https://github.com/user-attachments/assets/befbaab5-f419-4716-93a3-dc9ad4c5af38)

![Screenshot 2025-05-18 030352](https://github.com/user-attachments/assets/52927b52-b5d6-440a-8c7d-16225b6f463b)

![Screenshot 2025-05-18 030405](https://github.com/user-attachments/assets/2a9fcf95-b288-4174-b8ff-fa155847e772)

![Screenshot 2025-05-18 030420](https://github.com/user-attachments/assets/43794fc0-bf0f-4fb8-922a-7fc074e1d419)

![Screenshot 2025-05-18 030510](https://github.com/user-attachments/assets/b034bdce-99a7-4cf4-9f13-aae2e3415007)

![Screenshot 2025-05-18 031000](https://github.com/user-attachments/assets/9c14d64d-6674-456b-8f4f-be804d0c78b0)

![Screenshot 2025-05-18 031404](https://github.com/user-attachments/assets/28cabcd4-4bef-4ea1-884d-7d03af15b0fe)

![Screenshot 2025-05-18 031414](https://github.com/user-attachments/assets/aebf0787-fca9-4953-a7b5-1c13942302c2)

![Screenshot 2025-05-18 031838](https://github.com/user-attachments/assets/a0d5f25e-3d96-48c5-93a7-bd609f636269)

![Screenshot 2025-05-18 031949](https://github.com/user-attachments/assets/056cf830-55cc-4f81-9e8c-3fc1d3745526)

![Screenshot 2025-05-18 032119](https://github.com/user-attachments/assets/343c60a8-b850-4910-9f11-815afc470329)

![Screenshot 2025-05-18 032141](https://github.com/user-attachments/assets/22dd0c3e-3f6c-449b-b0c4-f7c12f6e83ef)

![Screenshot 2025-05-18 032215](https://github.com/user-attachments/assets/7afa7c93-91ca-456a-92f3-d81413210218)

![Screenshot 2025-05-18 032246](https://github.com/user-attachments/assets/b30db706-a7af-49b7-aec0-3777130f14ff)

![Screenshot 2025-05-18 032305](https://github.com/user-attachments/assets/2078a0d2-2fd7-4a5c-b908-04c8b77ad83e)

![Screenshot 2025-05-18 032405](https://github.com/user-attachments/assets/e5841ff6-8445-4a4d-a114-ef81034eead6)

![Screenshot 2025-05-18 032424](https://github.com/user-attachments/assets/9c8e1438-4fba-422e-a528-d3bb4dda8ae6)

![Screenshot 2025-05-18 032627](https://github.com/user-attachments/assets/26103b22-e7d9-4d85-a1bc-59c9ae562f7c)

![Screenshot 2025-05-18 032642](https://github.com/user-attachments/assets/62fe50eb-31eb-4e31-973c-bc2e8723309e)

![Screenshot 2025-05-18 032654](https://github.com/user-attachments/assets/49a4ddcf-a7d3-48c7-9b86-064ac1f700d4)

![Screenshot 2025-05-18 074350](https://github.com/user-attachments/assets/018c5aaf-75ae-4d71-8d2c-cd0a16737fd9)


```md
# Alright, it’s time for the final touches.
# Take a good look at the following diagram,
# then let’s get started.
```
![Screenshot 2025-05-20 111801](https://github.com/user-attachments/assets/dd91979c-422f-4a28-b9cb-143b19fe873c)

### Take a good look at the upcoming image—it’s important that we understand everything in it. Let’s quickly talk about what’s shown in the image.

![Screenshot 2025-06-07 203007](https://github.com/user-attachments/assets/3504a357-9a5b-40d0-8b0b-2066105423fc)

---

##  **General Overview**

This interface shows you how well your detection rules are functioning, whether they’re running on schedule, generating alerts, or missing executions (known as **gaps**).

---

##  **Breakdown of Each Section**

---

###  **Left Sidebar**

This contains the navigation menu:

* **Security**: Main security section in Kibana.
* **Dashboards**: Custom visualizations.
* **Rules**: Where you create, view, and monitor detection rules.
* **Alerts**: Shows alerts generated by the rules.
* **Attack discovery**: Automatically identifies potential attacks.
* **Findings**: Results from tools like cloud security posture management.
* **Cases**: Incident tracking system.
* **Timelines**: Tool for building investigations around related alerts/events.
* **Intelligence**: Threat intelligence feeds.
* **Explore**: Search and analyze security data freely.
* **Get started**: Intro page.
* **Manage**: Security settings and rule management.

---

###  **Top Section Tabs**

* **Installed Rules**: All detection rules installed on the system.
* **Rule Monitoring**: You’re here. It shows the **operational status** of rules (how often they run, if they failed, if there are gaps, etc.).

---

###  **Time Filter**

* **Last 24 hours**: Shows rules activity in the past 24 hours.

---

###  **Total Rules with Gaps: 1**

This means **1 rule failed to run properly** within the selected time range.

> A **gap** means the rule did **not run as scheduled**, which could result in missing some security events.

---

###  **Only rules with gaps (toggle)**

If enabled, the page will only show rules that **missed executions** (rules with gaps).

---

###  **Search Bar**

You can search rules by name, index pattern (like `"filebeat-*"`) or ATT\&CK technique IDs (e.g., `T1110` for brute force).

---

###  **Tags Filter**

You're filtering rules based on a **specific tag** (1 tag is applied here).

---

###  **Last response (dropdown)**

Filter or sort rules by their **last execution result** (e.g., success, failure, warning).

---

###  **Elastic Rules / Custom Rules Tabs**

* **Elastic rules (0)**: Built-in detection rules provided by Elastic.
* **Custom rules (1)**: Rules created by you or your team (in this case, one rule: "BruteForce").

---

###  **Enabled / Disabled Filters**

* **Enabled**: Rules that are currently active.
* **Disabled**: Rules that are turned off.

---

###  **Rules Table**

You can see the custom rule: **BruteForce**

#### Key Columns:

| Column            | Meaning                                                               |
| ----------------- | --------------------------------------------------------------------- |
| **Rule name**     | “BruteForce” – your custom rule. Blue dot = enabled.                  |
| **Indexing**      | Not shown in this image – usually relates to the data being searched. |
| **Query**         | Number of times the rule executed (3 times here).                     |
| **Last gap**      | The most recent gap was 2 days ago.                                   |
| **Unfilled gaps** | Rule missed execution for 2 full days (not yet recovered).            |
| **Last response** | Last run result was a **success** (✓).                                |
| **Last run**      | The rule last ran **2 hours ago**.                                    |

---

### ⋮ **Rule Options Menu (Right side)**

Clicking the 3-dot menu opens actions:

1. **Edit rule settings** – Change frequency, query, index, response actions, etc.
2. **Duplicate rule** – Clone the rule to make a new one.
3. **Export rule** – Save the rule config (e.g., for backups or reuse).
4. **Manual run** – Force the rule to run now.
5. **Delete rule** – Remove the rule completely.

---

###  **Untitled timeline (unsaved)**

This is a **Timeline** tool, used to investigate events related to alerts. I’ve started creating one but haven’t saved it yet.

---

##  **How This Page Helps**

* Monitor which rules are working properly.
* Detect gaps or problems in rule execution.
* Tune performance of security rules.
* Export or replicate rules across environments.
* Launch investigations with one click using Timelines.

--------
--------
> Now I’ll include the images that show our testing of the rule.
> If you want more explanation and details, go to the **rules** section in this repo—
> you’ll find detailed explanations of the rules, their testing, the logic behind them, the data, and the logs as well.
> [Rules Section](https://github.com/0xMOSTA-FU/siem-internship-phase-1/tree/main/siem-internship-phase-1/writeups/rules)

------------

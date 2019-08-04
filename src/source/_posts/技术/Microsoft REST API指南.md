---
title: Microsoft REST API指南
date: 2019-08-02 20:20:00
tags: Microsoft REST API指南中文翻译
categories:
  - 技术
---


# Microsoft REST API指南

## Microsoft REST API指南工作组

Name | Name | Name |
---------------------------- | -------------------------------------- | ----------------------------------------
Dave Campbell (CTO C+E)      | Rick Rashid (CTO ASG)                  | John Shewchuk (Technical Fellow, TED HQ)
Mark Russinovich (CTO Azure) | Steve Lucco (Technical Fellow, DevDiv) | Murali Krishnaprasad (Azure App Plat)
Rob Howard (ASG)             | Peter Torr  (OSG)                      | Chris Mullins (ASG)
  

<div style="font-size:100%">
Document editors: John Gossman (C+E), Chris Mullins (ASG), Gareth Jones (ASG), Rob Dolin (C+E), Mark Stafford (C+E)<br/>
</div>
 <br/>
<div style="font-size:100%">
感谢.NET长沙社区提供的翻译，感谢译者李文强，译者周尹 <br/>
本文首发 .NET社区公众号，欢迎关注, 搜索 MoreDotNetCore ,里面有最新的原创性资讯，获得第一手的资料。
</div>

# Microsoft REST API指南
## 摘要
Microsoft REST API指南作为一种设计原则，鼓励应用程序开发人员通过RESTful HTTP接口访问资源。

文档原则认为REST API应该遵循一致的设计指导原则，能为开发人员提供最流畅的体验，令使用它们变得简单和直观。

本文档建立了Microsoft REST API应该遵循的指导原则，以便统一一致的开发RESTful接口。

## 2. 目录
 <!-- TOC depthFrom:2 depthTo:4 orderedList:false updateOnSave:false withLinks:true -->

- [Microsoft REST API Guidelines Working Group](#microsoft-rest-api-guidelines-working-group)
- [1. 摘要](#1-abstract)
- [2. 目录](#2-table-of-contents)
- [3. 介绍](#3-introduction)
    - [3.1. 推荐阅读](#31-recommended-reading)
- [4. 解读指导](#4-interpreting-the-guidelines)
    - [4.1. 应用指导](#41-application-of-the-guidelines)
    - [4.2. 现有服务指南和服务版本化](#42-guidelines-for-existing-services-and-versioning-of-services)
    - [4.3. 要求的语言](#43-requirements-language)
    - [4.4. 许可证](#44-license)
- [5. 分类 ](#5-taxonomy)
    - [5.1. 错误](#51-errors)
    - [5.2. 故障](#52-faults)
    - [5.3. 潜在因素](#53-latency)
    - [5.4. 完成时间](#54-time-to-complete)
    - [5.5. 长期运行的API故障](#55-long-running-api-faults)
- [6. 客户端指导](#6-client-guidance)
    - [6.1. 忽略规则](#61-ignore-rule)
    - [6.2. 变量排序规则](#62-variable-order-rule)
    - [6.3. 无声失效规则](#63-silent-fail-rule)
- [7. 一致性基础](#7-consistency-fundamentals)
    - [7.1. 网址结构](#71-url-structure)
    - [7.2. 网址长度](#72-url-length)
    - [7.3. 标准标识符](#73-canonical-identifier)
    - [7.4. 支持方法](#74-supported-methods)
        - [7.4.1. POST](#741-post)
        - [7.4.2. PATCH](#742-patch)
        - [7.4.3. Creating resources via PATCH (UPSERT semantics)](#743-creating-resources-via-patch-upsert-semantics)
        - [7.4.4. Options and link headers](#744-options-and-link-headers)
    - [7.5. 标准请求请求头](#75-standard-request-headers)
    - [7.6. 响应请求头](#76-standard-response-headers)
    - [7.7. 自定义请求头](#77-custom-headers)
    - [7.8. 指定头部为查询参数](#78-specifying-headers-as-query-parameters)
    - [7.9. PII 参数](#79-pii-parameters)
    - [7.10. 响应格式](#710-response-formats)
        - [7.10.1. Clients-specified response format](#7101-clients-specified-response-format)
        - [7.10.2. Error condition responses](#7102-error-condition-responses)
    - [7.11. HTTP状态码](#711-http-status-codes)
    - [7.12. 可选的客户端库](#712-client-library-optional)
- [8. CORS 跨域](#8-cors)
    - [8.1. 客户端指导](#81-client-guidance)
        - [8.1.1. 预检](#811-avoiding-preflight)
    - [8.2. 服务端指导](#82-service-guidance)
- [9. 集合](#9-collections)
    - [9.1. 项的key](#91-item-keys)
    - [9.2. 序列化](#92-serialization)
    - [9.3. 集合URL模式](#93-collection-url-patterns)
        - [9.3.1. Nested collections and properties](#931-nested-collections-and-properties)
    - [9.4. 大集合](#94-big-collections)
    - [9.5. 修改集合](#95-changing-collections)
    - [9.6. 集合排序](#96-sorting-collections)
        - [9.6.1. Interpreting a sorting expression](#961-interpreting-a-sorting-expression)
    - [9.7. 过滤](#97-filtering)
        - [9.7.1. Filter operations](#971-filter-operations)
        - [9.7.2. Operator examples](#972-operator-examples)
        - [9.7.3. Operator precedence](#973-operator-precedence)
    - [9.8. 分页](#98-pagination)
        - [9.8.1. Server-driven paging](#981-server-driven-paging)
        - [9.8.2. Client-driven paging](#982-client-driven-paging)
        - [9.8.3. Additional considerations](#983-additional-considerations)
    - [9.9. 复合集合操作](#99-compound-collection-operations)
- [10. 增量查询](#10-delta-queries)
    - [10.1. 增量链接](#101-delta-links)
    - [10.2. 实体表示](#102-entity-representation)
    - [10.3. 获得增量链接](#103-obtaining-a-delta-link)
    - [10.4. 增量链接响应内容](#104-contents-of-a-delta-link-response)
    - [10.5. 使用增量链接](#105-using-a-delta-link)
- [11. JSON标准化](#11-json-standardizations)
    - [11.1. 主要类型的JSON格式化标准化](#111-json-formatting-standardization-for-primitive-types)
    - [11.2. 日期和时间指南](#112-guidelines-for-dates-and-times)
        - [11.2.1. Producing dates](#1121-producing-dates)
        - [11.2.2. Consuming dates](#1122-consuming-dates)
        - [11.2.3. Compatibility](#1123-compatibility)
    - [11.3. 日期和时间的JSON序列化](#113-json-serialization-of-dates-and-times)
        - [11.3.1. The `DateLiteral` format](#1131-the-dateliteral-format)
        - [11.3.2. Commentary on date formatting](#1132-commentary-on-date-formatting)
    - [11.4. 持续时间](#114-durations)
    - [11.5. 间隔](#115-intervals)
    - [11.6. 重复间隔](#116-repeating-intervals)
- [12. 版本](#12-versioning)
    - [12.1. 版本格式](#121-versioning-formats)
        - [12.1.1. Group versioning](#1211-group-versioning)
    - [12.2. 版本的时间](#122-when-to-version)
    - [12.3. 非延续性更改的定义](#123-definition-of-a-breaking-change)
- [13. 长时间运行的操作](#13-long-running-operations)
    - [13.1. 基于资源的长时间运行(RELO)](#131-resource-based-long-running-operations-relo)
    - [13.2. 分步运行的长时间操作](#132-stepwise-long-running-operations)
        - [13.2.1. PUT](#1321-put)
        - [13.2.2. POST](#1322-post)
        - [13.2.3. POST, hybrid model](#1323-post-hybrid-model)
        - [13.2.4. Operations resource](#1324-operations-resource)
        - [13.2.5. Operation resource](#1325-operation-resource)
        - [13.2.6. Operation tombstones](#1326-operation-tombstones)
        - [13.2.7. The typical flow, polling](#1327-the-typical-flow-polling)
        - [13.2.8. The typical flow, push notifications](#1328-the-typical-flow-push-notifications)
        - [13.2.9. Retry-After](#1329-retry-after)
    - [13.3. 操作结果保留策略](#133-retention-policy-for-operation-results)
- [14. Throttling, Quotas, and Limits](#14-throttling-quotas-and-limits)
    - [14.1. Principles](#141-principles)
    - [14.2. Return Codes (429 vs 503)](#142-return-codes-429-vs-503)
    - [14.3. Retry-After and RateLimit Headers](#143-retry-after-and-ratelimit-headers)
    - [14.4. Service Guidance](#144-service-guidance)
        - [14.4.1. Responsiveness](#1441-responsiveness)
        - [14.4.2. Rate Limits and Quotas](#1442-rate-limits-and-quotas)
        - [14.4.3. Overloaded services](#1443-overloaded-services)
        - [14.4.4. Example Response](#1444-example-response)
    - [14.5. Caller Guidance](#145-caller-guidance)
    - [14.6. Handling callers that ignore Retry-After headers](#146-handling-callers-that-ignore-retry-after-headers)
- [15. 通过webhooks推送通知](#15-push-notifications-via-webhooks)
    - [15.1. 范围](#151-scope)
    - [15.2. 原则](#152-principles)
    - [15.3. 订阅类型](#153-types-of-subscriptions)
    - [15.4. 调用序列](#154-call-sequences)
    - [15.5. 验证订阅](#155-verifying-subscriptions)
    - [15.6. 接收通知](#156-receiving-notifications)
        - [15.6.1. Notification payload](#1561-notification-payload)
    - [15.7. programmatically订阅管理](#157-managing-subscriptions-programmatically)
        - [15.7.1. Creating subscriptions](#1571-creating-subscriptions)
        - [15.7.2. Updating subscriptions](#1572-updating-subscriptions)
        - [15.7.3. Deleting subscriptions](#1573-deleting-subscriptions)
        - [15.7.4. Enumerating subscriptions](#1574-enumerating-subscriptions)
    - [15.8. 安全性](#158-security)
- [16. 不支持的请求](#16-unsupported-requests)
    - [16.1. 基本指导](#161-essential-guidance)
    - [16.2. 特征允许列表](#162-feature-allow-list)
        - [16.2.1. Error response](#1621-error-response)
- [17. 命名准则](#17-naming-guidelines)
    - [17.1. 途径](#171-approach)
    - [17.2. 框架](#172-casing)
    - [17.3. 避免的命名](#173-names-to-avoid)
    - [17.4. 规范的复合词](#174-forming-compound-names)
    - [17.5. 标识属性](#175-identity-properties)
    - [17.6. 日期和时间属性](#176-date-and-time-properties)
    - [17.7. 属性名](#177-name-properties)
    - [17.8. 集合和计数](#178-collections-and-counts)
    - [17.9. 共同属性命名](#179-common-property-names)
- [18. 附录](#18-appendix)
    - [18.1. 时序图注释](#181-sequence-diagram-notes)
        - [18.1.1. Push notifications, per user flow](#1811-push-notifications-per-user-flow)
        - [18.1.2. Push notifications, firehose flow](#1812-push-notifications-firehose-flow)

<!-- /TOC -->

## 3. 引言
开发人员通常通过HTTP接口访问大多数微软云平台资源。虽然每个服务通常提供特定于语言框架来包装其API，但它们的所有操作最终都归结为HTTP请求。微软必须支持广泛的客户端和服务，不能依赖于每个开发环境都有丰富的框架。因此，本指导原则的目标是确保Microsoft REST API能够被任何具有基本HTTP支持的客户端轻松且一致地使用。
[*]译者注：本指南不限于微软技术和平台，广泛适应于各种语言和平台。

为了给开发人员提供最流畅的体验，让这些API遵循统一的设计准则是很重要的，从而使其简单易用，符合人们的直觉反应。本文档建立了 Microsoft REST API 开发人员应该遵循的指南, 以便统一一致地开发API。

一致性的好处在于可以不断地积累合理的规范;一致性使团队拥有统一的代码、模式、文档风格和设计策略。

这些准则旨在达成如下目标：
- 为Microsoft技术平台所有API端点定义一致的实现和体验。
- 尽可能地遵循行业普遍接受的 REST/HTTP 最佳实践。
- 让所有应用开发者都可以轻松的通过REST接口访问Micosoft服务。
- 允许Service开发者利用其他Service的基础上来开发一致的REST API端点。
- 允许合作伙伴(例如,非Micosoft团队)使用这些准则来设计自己的 REST API。
[*]注：本指南旨在构建符合 REST 架构风格的服务，但不涉及或要求构建遵循 REST 约束的服务。
本文档中使用的“REST”术语代指具有 RESTful风格的服务，而不是仅仅遵循 REST。

### 3.1 推荐阅读
了解REST架构风格背后的理念，更有助于开发优秀的基于 HTTP 的服务。
如果您对 RESTful 设计不熟悉，请参阅以下优秀资源：
- REST on Wikipedia — 维基百科上关于REST的核心概念与思想的介绍。
- REST论文—— Roy Fielding网络架构论文中关于REST的章节，“架构风格与基于网络的软件体系结构设计”
- RFC 7231—— 定义HTTP/1.1 语义规范的权威资源。
- REST 实践—— 关于REST的基础知识的入门书。

[*]译者注：上一篇说了，REST 指的是一组架构约束条件和原则。那么满足这些约束条件和原则的应用程序或设计就是 RESTful。

## 4. 解读指导 
### 4.1 应用指南
这些准则适用于Microsoft或任何合作伙伴服务公开的任何REST API。私有或内部API也应该尝试遵循这些准则，因为内部服务最终可能会被公开。保证一致性不仅对外部客户有价值，对内部服务使用者也很有价值，而这些准则为对任何服务都提供了最佳实践。
有合理理由可不遵循这些准则。如：实现或必须与某些外部定义的REST API互操作的REST服务必须与哪些外部的API兼容，而无法遵循这些准则。而还有一些服务也可能具有需要特殊性能需求，必须采用其他格式，例如二进制协议。

### 4.2 现有服务和服务版本控制的指南
我们不建议仅仅为了遵从指南而对这些指南之前的旧服务进行重大更改。无论如何，当兼容性被破坏时，该服务应该尝试在下一版本发布时变得合规。
当一个服务添加一个新的API时，该API应该与同一版本的其他API保持一致。
因此，如果服务是针对 1.0 版本的指南编写的，那么增量添加到服务的新 API 也应该遵循 1.0 版本指南。然后该服务在下一次主要版本更新时，再去遵循最新版指南。 

### 4.3 要求语言
本文档中的"MUST"（必须）, "MUST NOT"（禁止）, "REQUIRED"（需要）, "SHALL"（将要）, "SHALL NOT"（最好不要）, "SHOULD"（应该）, "SHOULD NOT"（不应该）, "RECOMMENDED"（推荐）, "MAY"（可能）, 和 "OPTIONAL"（可选） 等关键字的详细解释见 RFC 2119。

### 4.4 许可证
本作品根据知识共享署名4.0国际许可协议授权。如需查看本授权的副本，请访问http://creativecommons.org/licenses/by/4.0/ 或致函  PO Box 1866, Mountain View, CA 94042, USA.

[*]译者注：署名 4.0 国际，也就是允许在任何媒介以任何形式复制、发行本作品，允许修改、转换或以本作品为基础进行创作。允许任何用途，甚至商业目的。

## 5. 分类
作为Microsoft REST API指南的一部分，服务必须符合下面定义的分类法。

### 5.1 错误
错误，或者更具体地说是服务错误，定义为因客户端向服务传递错误数据，导致服务端拒绝该请求。示例包括无效凭证、错误的参数、未知的版本ID等。客户端传递错误的或者不合法的数据的情况通常返回 “4XX” 的 HTTP 错误代码。

错误不会影响API的整体可用性。

[*]译者注：错误可以理解成客户端参数错误，通常返回“4XX”状态码，并不影响整体的API使用。

### 5.2 故障
故障（缺陷），或者更具体地说是服务故障，定义为服务无法正确返回数据以响应有效的客户端请求。通常会返回“5xx”HTTP错误代码。

故障会影响整体 API 的可用性。
由于速率限制（限流）或配额故障而失败的调用不能算作故障。由于服务快速失败(fast-failing)请求(通常是为了保护自己)而失败的调用会被视为故障。

[*]译者注：故障意味着服务端代码出现故障，可能会影响整体的API使用。比如数据库连接超时。
fast-failing 快速失败
safe-failing 安全失败

### 5.3 延迟
延迟定义为特定的API调用完成所需的时间(尽可能使用客户端调用进行测量)。此测量方法同样适用于同步和异步的API。对于长时间运行(long running calls)的调用，延迟定义为第一次调用它所需的时长，而不是整个操作)完成所需的时间。

[*]译者注：Latency（延迟）是衡量软件系统的最常见的指标之一，不仅仅和系统、架构的性能相关，还和网络传输和延迟有关系。

### 5.4 完成时间
暴露长时间操作的服务必须跟踪这些操作的 "完成时间" 指标。

### 5.5 长期运行API故障
对于长期运行的 API，很可能出现第一次请求成功，且后续每次去获取结果时 API 也处于正常运行（每次都回传 200）中，但其底层操作已经失败了的情况。长期运行故障必须作为故障汇总到总体可用性指标中。

## 6. 客户端指导
为确保客户端更好的接入REST服务，客户端应遵循以下最佳实践:

### 6.1 忽略规则
对于松散耦合的客户端调用，在调用之前不知道数据的确切定义和格式，如果服务器没用返回客户端预期的内容，客户端必须安全地忽略它。

在服务迭代的过程中，有些服务（接口）可能在不更改版本号的情况下向响应添加字段。此类服务必须在其文档中注明，客户端必须忽略这些未知字段。

[*]译者注：一个已发布的在线接口服务，如果不修改版本而增加字段，那么一定不能影响已有的客户端调用。

### 6.2 变量排序规则
客户端处理响应数据时一定不能依赖服务端JSON响应数据字段的顺序。例如，例如，当服务器返回的 JSON 对象中的字段顺序发生变化，客户端应当能够正确进行解析处理。
当服务端支持时，客户端可以请求以特定的顺序返回数据。例如，服务端可能支持使用$orderBy querystring参数来指定JSON数组中元素的顺序。
服务端也可以在协议中显式说明指定某些元素按特定方式进行排序。例如，服务端可以每次返回 JSON 对象时都把 JSON 对象的类型信息作为第一个字段返回，进而简化客户端解析返回数据格式的难度。客户端处理数据时可以依赖于服务端明确指定了的排序行为。

### 6.3 无声失效规则
当客户端请求带可选功能参数的服务时（例如带可选的头部信息），必须对服务端的返回格式有一定兼容性，可以忽略某些特定功能。

[*]译者注：例如分页数、排序等自定义参数的支持和返回格式的兼容。

## 7. 基础原则

### 7.1 URL结构

URL必须保证友好的可读性与可构造性，人类应该能够轻松地读取和构造url。:)
这有助于用户发现并简化接口的调用，即使平台没有良好的客户端SDK支持。
[*]译者注：API URL路径结构应该是友好的易于理解的。甚至用户无需通过阅读API文档能够猜出相关结构和路径。

结构良好的URL的一个例子是:
https://api.contoso.com/v1.0/people/jdoe@contoso.com/inbox
[*]译者注：通过以上URL我们可以获知API的版本、people资源、用户标识（邮箱）、收件箱，而且很容易获知——这是jdoe的收件箱的API。

一个不友好的示例URL是:
https://api.contoso.com/EWS/OData/Users('jdoe@microsoft.com')/Folders('AAMkADdiYzI1MjUzLTk4MjQtNDQ1Yy05YjJkLWNlMzMzYmIzNTY0MwAuAAAAAACzMsPHYH6HQoSwfdpDx-2bAQCXhUk6PC1dS7AERFluCgBfAAABo58UAAA=')
[*]译者注：这是ODATA的API，不过目录标识不易于理解，没什么意义。

出现的常见模式是使用URL作为值（参数）。服务可以使用URL作为值。
例如，以下内容是可以接受的(URL中，url参数传递了花式的鞋子这个资源):
https://api.contoso.com/v1.0/items?url=https://resources.contoso.com/shoes/fancy
[*]译者注：Token第三方认证中把登陆前来源地址返回给客户端。

### 7.2 URL长度
HTTP 1.1消息格式(在第3.1.1节的RFC 7230中定义)对请求没有长度限制，其中包括目标URL。RFC的:
> HTTP没有对请求行长度设置预定义的限制。[…如果服务器接收到的请求目标比它希望解析的任何URI都长，那么它必须使用 414 (URI太长)状态代码进行响应。

服务如果能够生成超过2,083个字符的url，必须考虑兼容它支持的客户端。不同客户端支持的最长 URL 长度参见以下资料：
- http://stackoverflow.com/a/417184
- https://blogs.msdn.microsoft.com/ieinternals/2014/08/13/url-length-limits/

还请注意，一些技术栈有强制的的URL限定，所以在设计服务时要记住这一点。

### 7.3 规范标识符
除了提供友好的URL之外，能够移动或重命名的资源必须包含唯一稳定的标识符。
在与 服务 进行交互时可能需要通过友好的名称来获取资源固定的 URL，就像某些服务使用的“/my”快捷方式一样。
指南不强制要求 固定标识符使用GUID。
包含规范标识符的URL的一个例子是（标识符比较友好):
  https://api.contoso.com/v1.0/people/7011042402/inbox
  
[*]译者注：一般是暴露主键字段，也可以是其他唯一的易于理解的字段，比如姓名、标题、邮箱等等。
[*]译者注：GUID太长而且不易于理解和阅读，如果不是必须，尽量少用此字段。

### 7.4 支持方法
客户端必须尽可能使用正确的HTTP动词来执行操作，并且必须考虑是否支持此操作的幂等性。HTTP方法通常称为HTTP动词。

在此上下文中，术语是同义词，但是HTTP规范使用术语方法。

下面是Microsoft REST服务应该支持的方法列表。并不是所有资源都支持所有方法，但是使用以下方法的所有资源必须符合它们的用法。

| Method  |  Description | Is Idempotent
|:--|:--|
| GET | 返回对象的当前值 | True
| PUT | 在适用时替换对象，或创建命名对象 | True
| DELETE | 删除对象 | True
| POST | 根据提供的数据创建一个新对象，或者提交一个操作 | False
| HEAD | 返回GET响应的对象的元数据。支持GET方法的资源也可能支持HEAD方法 | True
| PATCH | 更新对象部分应用 | False
| OPTIONS | 获取关于请求的信息;详见下文。 | True

#### 7.4.1  POST

POST操作应该支持重定向响应标头（Location），以便通过重定向标头返回创建好的资源的链接。

例如，假设一个服务允许创建并命名托管服务器:

> POST http://api.contoso.com/account1/servers
响应应该是这样的:

> 201 Created
> Location:http://api.contoso.com/account1/servers/server321

其中“server321”是服务分配的服务器名。

服务还可以在响应中返回已创建项的完整元数据。

#### 7.4.2. PATCH
PATCH已被IETF标准化为用于增量更新现有对象的方法（参见RFC 5789）。符合Microsoft REST API准则的API应该支持PATCH。

#### 7.4.3. Creating resources via PATCH (UPSERT semantics) 通过 PATCH 创建资源（UPSERT 定义）
允许客户端在创建资源的时候只指定部分键值（key）数据的必须支持UPSET语义，该服务必须支持以PATCH动词来创建资源。

鉴于PUT被定义为内容的完全替换，所以客户端使用PUT修改数据是危险的。

当试图更新资源时，不理解(并因此忽略)资源的某些属性的客户端，很可能在PUT上忽视这些属性，导致提交后这些属性可能在不经意间被删除。

所以，如果选择支持PUT来更新现有资源，则必须是完整替换(即，PUT之后，资源的属性必须匹配请求中提供的内容，包括删除没有提供的任何服务端的属性)。

在UPSERT语义下，对不存在资源的 PATCH 调用，由服务器作为“创建”处理，对已存在的资源的 PATCH 调用作为“更新”处理。
为了确保更新请求不被视为创建（反之亦然），客户端可以在请求中指定预先定义的 HTTP 请求头。
- 如果 PATCH 请求包含if-match标头，则服务不能将其视为插入;如果 PATCH 请求包含值为 “*” 的if-none-match头，则服务不能将其视为更新。

如果服务不支持UPSERT，则针对不存在的资源的 PATCH 调用必须导致 HTTP “409 Conflict”错误。

#### 7.4.4  Options 标头 和 link headers 标签

OPTIONS 允许客户端查询某个资源的元信息，并至少可以通过返回支持该资源的有效方法（支持的动词类别）的Allow 标头。
[*]译者注：当发起跨域请求时，浏览器会自动发起OPTIONS请求进行检查。

此外，建议服务返回应该包括一个指向有关资源的稳定链接（Link header）(见RFC 5988):

```http
Link: <{help}>; rel="help"
```

其中{help}是指向文档资源的URL。

有关选项使用的示例，请参见完善CORS跨域调用。

### 7.5 标准的请求标头

下面的请求标头表 应该遵循 Microsoft REST API指南服务使用。使用这些标题不是强制性的，但如果使用它们则必须始终一致地使用。

所有标头值都必须遵循规范中规定的标头字段所规定的语法规则。许多HTTP标头在RFC7231中定义，但是在IANA标头注册表中可以找到完整的已批准头列表。

| Header 标头| Type 类型 | Description 描述 |
|:--|:--|:--|
| Authorization | String | 请求的授权标头 |
| Date | Date | 请求的时间戳，基于客户端的时钟，采用RFC 5322日期和时间格式。服务器不应该对客户端时钟的准确性做任何假设。此标头可以包含在请求中，但在提供时必须采用此格式。当提供此报头时，必须使用格林尼治平均时间(GMT)作为时区参考。例如：Wed, 24 Aug 2016 18:41:30 GMT. 请注意，GMT正好等于UTC（协调世界时）。 |
| Accept | Content type |  响应请求的内容类型，如: 
- application/xml
- text/xml
- application/json
- text/javascript (for JSONP)
根据HTTP准则，这只是一个提示，响应可能有不同的内容类型，例如blob fetch，其中成功的响应将只是blob流作为有效负载。对于遵循OData的服务，应该遵循OData中指定的首选项顺序。|
| Accept-Encoding | Gzip, deflate | 如果适用，REST端点应该支持GZIP和DEFLATE编码。对于非常大的资源，服务可能会忽略并返回未压缩的数据。 |
| Accept-Language | "en", "es", etc. | 指定响应的首选语言。不需要服务来支持这一点，但是如果一个服务支持本地化，那么它必须通过Accept-Language头来支持本地化。 |
| Accept-Charset | Charset type like "UTF-8" | 
默认值是UTF-8，但服务应该能够处理ISO-8859-1 |
| Content-Type | Content type | Mime type of request body (PUT/POST/PATCH) |
| Prefer | return=minimal, return=representation | 如果指定了return = minimal首选项，则服务应该返回一个空主体（empty body）以响应一次成功插入或更新。如果指定了return = representation，则服务应该在响应中返回创建或更新的资源。如果服务的场景中客户端有时会从响应中获益，但有时响应会对带宽造成太大的影响，那么它们应该支持这个报头。 |
| If-Match, If-None-Match, If-Range | String | 使用乐观并发控制支持资源更新的服务必须支持If-Match标头。服务也可以使用其他与ETag相关的头，只要它们遵循HTTP规范。 |

## 7.6 标准响应标头

服务应该返回以下响应标头，除非在“required”列中注明。

| Response Header | Required | Description |
| 响应报头 | 必填 | 描述 | 
|:--|:--|:--|
| Date | All responses | 根据服务器的时钟，以RFC 5322日期和时间格式处理响应。这个头必须包含在响应中。此报头必须使用格林尼治平均时间(GMT)作为时区参考。例如:Wed, 24 Aug 2016 18:41:30 GMT.请注意，GMT正好等于协调世界时(UTC)。 |
| Content-Type |  All responses| 内容类型 |
| Content-Encoding | All responses | GZIP或DEFLATE，视情况而定 |
| Preference-Applied | 在请求中指定时 | 是否应用了首选项请求头中指示的首选项 | 
| ETag | 当请求的资源具有实体标记时 | ETag响应头字段为请求的变量提供实体标记的当前值。与If-Match、If-None-Match和If-Range一起使用，实现乐观并发控制。 | 

## 7.7. 自定义标头
基本的API操作不应该支持自定义标头。

本文档中的一些准则规定了非标准HTTP标头的使用。此外，某些服务可能需要添加额外的功能，这些功能通过HTTP标头文件公开。以下准则有助于在使用自定义标头时保持一致性。

非标准HTTP标头必须具有以下两种格式之一:
1. 使用IANA（RFC 3864）注册为“临时”的标头的通用格式
2. 为注册使用过特定的头文件的范围格式
这两种格式如下所述。

## 7.8. 以查询参数方式提交自定义请求头
有些标头对某些场景(如AJAX客户端)不兼容，特别是在不支持添加标头的跨域调用时。因此，除了常见的标头信息外，一些标头信息可以允许被作为查询参数传递给服务端，其命名与请求头中的名称保持一致:

并不是所有的标头都可以用作查询参数，包括大多数标准HTTP标头。
考虑何时接受标头作为参数的标准如下:
1. 任何自定义标头也必须作为参数接受。
2. 请求的标准标头也可以作为参数接受。 
3. 具有安全敏感性的必需标头(例如，授权标头 Authorization)可能不适合作为参数;服务所有者应该具体情况具体分析。

此规则的一个例外是Accept头。使用具有简单名称的方案，而不是使用HTTP规范中描述的用于Accept的完整功能，这是一种常见的实践。

## 7.9. PII 个人身份信息参数
与普遍的隐私政策一致，客户端不应该在URL中传输个人身份信息(PII)参数(作为路径或查询参数)，因为这些信息可能通过客户端、网络和服务器日志和其他机制无意暴露出来。

因此，服务应该接受PII参数作为标头传输。

然而在实践中，由于客户端或软件的限制，在许多情况下无法遵循上述建议。为了解决这些限制，服务也应该接受这些PII参数作为URL的一部分，与本指导原则的其余部分保持一致。

接受PII参数(无论是在URL中还是作为标头)的服务 应该符合其组织的隐私保护原则。通常建议包括：客户端使用标头进行加密传输，并且实现要遵循特殊的预防措施，以确保日志和其他服务数据收集得到正确的处理。

[*]译者注：PII——个人可标识信息。比如家庭地址，身份证信息。

## 7.10. Response formats 响应格式
一个成功的平台，往往提供可读性较好并且一致的响应结果，并允许开发人员使用公共 Http 代码处理响应。

基于Web的通信，特别是当涉及移动端或其他低带宽客户端时，我们推荐使用JSON作为传输格式。主要是由于其更轻量以及易于与JavaScript交互。

JSON属性名应该采用camelCasedE驼峰命名规范。

服务应该提供JSON作为默认输出格式。

### 7.10.1 Clients-specified 客户端指定响应格式

在HTTP中，客户端应该使用Accept头请求响应格式。 服务端可以选择性的忽略，如客户端发送多个Accept标头，服务可以选择其中一个格式进行响应。

默认的响应格式(没有提供Accept头)应该是application/json，并且所有服务必须支持application/json。

| Accept Header | Response type | Notes |
| 接受标头 | 响应类型 | 备注 |
|:--|:--|:--|
| application/json	 | 必须是返回json格式 | 同样接受JSONP请求的text/JavaScript |

```GET https://api.contoso.com/v1.0/products/user
Accept: application/json
```

### 7.10.2 错误的条件响应
对于调用不成功的情况，开发人员应该能够用相同的代码库一致地处理错误。这允许构建简单可靠的基础架构来处理异常，将异常作为成功响应的独立处理流程来处理。下面的代码基于OData v4 JSON规范。但是，它非常通用，不需要特定的OData构造。即使api没有使用其他OData结构，也应该使用这种格式。

错误响应必须是单个JSON对象。该对象必须有一个名为“error”的 名称/值（name/value） 对。该值必须是JSON对象。

这个对象必须包含名称“code”和“message”的 键值对，并且它建议包含譬如“target”、“details”和 “innererror” 的键值对。

“code”键值对的值 是一个与语言无关的字符串。它的值是该服端务定义的错误代码，应该简单可读。与响应中指定的HTTP错误代码相比，此代码用作错误的更具体的指示。服务应该具有相对较少的“code”数量(别超过20个)，并且所有客户端必须能够处理所有这些错误信息。
大多数服务将需要更大数量的更具体的错误代码以满足所有的客户端请求。这些错误代码应该在“innererror” 键值对中公开，如下所述。为现有客户端可见的“代码”引入新值是一个破坏性的更改，需要增加版本。服务可以通过向“innererror”添加新的错误代码来避免中断服务更改。

“message”键值对的值 必须是错误提示消息，必须是可读且易于理解。它旨在是帮助开发人员，不适合暴露给最终用户。想要为最终用户公开合适消息的服务必须通过annotation注释或其他自定义属性来公开。服务不应该为最终用户本地化“message”，因为这样对于开发者变得非常不友好并且难以处理。

“target”键值对的值 是指向错误的具体的目标(例如，错误中属性的名称)。

“details”键值对的值 必须是JSON对象数组，其中必须包含“code”和“message”的键值对，还可能包含“target”的键值对，如上所述。“details”数组中的对象通常表示请求期间发生的不同的、相关的错误。请参见下面的例子。

“innererror”键值对的值 必须是一个对象。这个对象的内容是服务端定义的。想要返回比根级别代码更具体的错误的服务，必须包含“code”的键值对和嵌套的“innererror”。每个嵌套的“innererror”对象表示比其父对象更高层次的细节。在评估错误时，客户端必须遍历所有嵌套的“内部错误”，并选择他们能够理解的最深的一个。这个方案允许服务在层次结构的任何地方引入新的错误代码，而不破坏向后兼容性，只要旧的错误代码仍然出现。服务可以向不同的调用者返回不同级别的深度和细节。例如，在开发环境中，最深的“innererror”可能包含有助于调试服务的内部信息。为了防范信息公开带来的潜在安全问题，服务应注意不要无意中暴露过多的细节。错误对象还可以包括特定于代码的自定义服务器定义的键值对。带有自定义服务器定义属性的错误类型应该在服务的元数据文档中声明。请参见下面的例子。

错误响应返回的的任何JSON对象中都可能包含注释。

我们建议，对于任何可能重试的临时错误，服务应该包含一个  Retry-After  HTTP头，告诉客户端在再次尝试操作之前应该等待的最小秒数。

##### ErrorResponse : Object

Property | Type | Required | Description
-------- | ---- | -------- | -----------
`error` | Error | ✔ | The error object.

##### Error : Object

Property | Type | Required | Description
-------- | ---- | -------- | -----------
`code` | String (enumerated) | ✔ | 服务器定义的错误代码集之一。`message` | String | ✔ | A human-readable representation of the error.
`target` | String |  | The target of the error.
`details` | Error[] |  | An array of details about specific errors that led to this reported error.
`innererror` | InnerError |  | An object containing more specific information than the current object about the error.

##### InnerError : Object

Property | Type | Required | Description
-------- | ---- | -------- | -----------
`code` | String |  | A more specific error code than was provided by the containing error.
`innererror` | InnerError |  | An object containing more specific information than the current object about the error.

##### Examples

内部错误的例子:

```json
{
  "error": {
    "code": "BadArgument",
    "message": "Previous passwords may not be reused",
    "target": "password",
    "innererror": {
      "code": "PasswordError",
      "innererror": {
        "code": "PasswordDoesNotMeetPolicy",
        "minLength": "6",
        "maxLength": "64",
        "characterTypes": ["lowerCase","upperCase","number","symbol"],
        "minDistinctCharacterTypes": "2",
        "innererror": {
          "code": "PasswordReuseNotAllowed"
        }
      }
    }
  }
}
```

在本例中，基本的错误代码是“BadArgument”，但是对于感兴趣的客户端，“innererror”中提供了更具体的错误代码。
“passwordreusenotal”代码可能是在之后的迭代中由该服务添加的，之前只返回“passwordnotmeetpolicy”。
这种增量型的添加方式并不会破坏老的客户端的处理过程，而又可以给开发者一些更详细的信息。
“PasswordDoesNotMeetPolicy”错误还包括额外的键值对，这些键值对 允许客户机确定服务器的配置、以编程方式验证用户的输入，或者在客户机自己的本地化消息传递中向用户显示服务器的约束。

详细的例子 "details":

```json
{
  "error": {
    "code": "BadArgument",
    "message": "Multiple errors in ContactInfo data",
    "target": "ContactInfo",
    "details": [
      {
        "code": "NullValue",
        "target": "PhoneNumber",
        "message": "Phone number must not be null"
      },
      {
        "code": "NullValue",
        "target": "LastName",
        "message": "Last name must not be null"
      },
      {
        "code": "MalformedValue",
        "target": "Address",
        "message": "Address is not valid"
      }
    ]
  }
}
```

在本例中，请求存在多处问题，每个错误都列在 "details" 字段中进行返回了。

### 7.11 HTTP状态代码 HTTP Status Codes
应使用标准HTTP状态码作为响应状态码; 更多信息，请参见HTTP状态代码定义。

### 7.12. 客户端库可选 Client library optional
开发人员必须能够在各种平台和语言上进行开发，比如Windows、macOS、Linux、c#、Python和Node.js或是Ruby。

服务应该能够让简单的HTTP工具(如curl)进行访问，而不需要做太多的工作。

该服务提供给开发人员的网站应该提供相当于“获得开发者令牌(Get developer Token)的功能，以帮助开发人员测试并应提供curl支持。

## 8. CORS 跨域
符合Microsoft REST API准则的服务必须支持[CORS(跨源资源共享)][CORS]。
服务应该支持CORS *的允许起源，并通过有效的OAuth令牌强制授权。
服务不应该支持带有源验证的用户凭据。
特殊情况可例外。

### 8.1. 客户端指导
Web开发人员通常不需要做任何特殊处理来利用CORS。
作为标准XMLHttpRequest调用的一部分，所有握手步骤都是不可见的。

许多其他平台（如.NET）已集成了对CORS的支持。

#### 8.1.1. 避免额外的预检查
由于CORS协议会触发向服务器添加额外往返的预检请求，因此，注重性能的应用程序可能会有意避免这些请求。
CORS背后的精神是避免对旧的不支持CORS功能的浏览器能够做出的任何简单的跨域请求进行预检。
所有其他请求都需要预检。

请求是“简单类型请求“，如果其方法是GET，HEAD或POST，并且除了Accept，Accept-Language和Content-Language之外它不包含任何请求标头，则可以免去预检。

对于POST请求，也允许使用Content-Type标头，但前提是其值为“application/x-www-form-urlencoded”，“multipart/form-data”或“text/plain”。
对于任何其他标头或值，将发生预检请求。

### 8.2. 服务指南
 服务必须至少：
 - 了解浏览器在跨域请求上发送的Origin请求标头，以及他们在检查访问权限的预检OPTIONS 请求上发送的 Access-Control-Request-Method请求标头。
 - 如果请求中存在Origin标头：
   - 如果请求使用 OPTIONS 方法并包含 Access-Control-Request-Method标头，则它是一个预检请求，用于在实际请求之前探测访问。否则，这是一个实际的请求。对于预检请求，除了执行以下步骤添加标头之外，服务必须不执行任何额外处理，并且必须返回 200 OK。对于非预检请求，除了请求的常规处理之外，还会添加以下标头。
   - 服务向响应添加 Access-Control-Allow-Origin  标头，其中包含与Origin 请求标头相同的值。请注意，这需要服务来动态生成标头值。不需要cookie或任何其他形式的[用户凭证] [cors-user-credentials]的资源可以使用通配符星号（*）进行响应。请注意，通配符仅在此处可接受，而不适用于下面描述的任何其他标头。

   - 如果调用者需要访问不属于[简单响应头] [cors-simple-headers]集合中的响应头（Cache-Control，Content-Language，Content-Type，Expires，Last-Modified，Pragma），同时添加一个Access-Control-Expose-Headers标头，其中包含客户端应有权访问的其他响应标头名称列表。
     [*]译者注：在跨域请求时，响应中的大部分header，需要服务端同意才能拿到，客户端跨域增加 Access-Control-Expose-Headers: content-type, cache …… 等标头来告知服务器。
     
   - 如果请求需要cookie，则添加一个Access-Control-Allow-Credentials头，并将其设置为“true”。
   - 如果请求是预检请求(见第一个项目符号)，则服务必须满足:
	   - 添加一个Access-Control-Allow-Headers响应标头，其中包含允许客户端使用的请求标头名称列表。这个列表只需要包含不在[简单请求头][rs-simple-headers] (Accept、Accept- language、Content-Language)集合中的头。如果服务接受的报头没有限制，则服务可以简单地返回与客户机发送的访问-控制-请求-报头报头相同的值。
	   - 添加一个Access-Control-Allow-Methods响应头，其中包含允许调用方使用的HTTP方法列表。

添加一个Access-Control-Max-Age pref

响应头，其中包含此预检前响应有效的秒数(因此可以在后续实际请求之前避免)。注意，虽然习惯上使用较大的值，比如2592000(30天)，但是许多浏览器会自动设置一个更低的限制(例如，5分钟)。

众所周知，由于浏览器预检响应缓存很弱，因此预检响应的额外往返会损害性能。
 [*]译者注：获取预检OPTIONS调用会造成很大开销，而且也浏览器的缓存能力也很赢弱，而且部分浏览器也不会理会access-control-max-age的设置值，如Chrome/Blink 就硬编码为10分钟（600秒）。详见[https://chromium.googlesource.com/chromium/blink/+/master/Source/core/loader/CrossOriginPreflightResultCache.cpp#40]

注重性能端的交互式 Web客户端使用的服务端应该避免使用导致预检的请求。
- 对于GET和HEAD调用，请避免要求不属于上述简单集的请求标头。最好是允许将它们作为查询参数提供。
	- Authorization标头不是简单集的一部分，因此对于需要验证的资源，必须通过“access_token”查询参数发送验证令牌。请注意，不建议在URL中传递身份验证令牌，因为它可能导致令牌记录在服务器日志中，并暴露给有权访问这些日志的任何人。通过URL接受身份验证令牌的服务必须采取措施来降低安全风险，例如使用短期身份验证令牌，禁止记录身份验证令牌以及控制对服务器日志的访问。

- 避免要求cookie。如果设置了“withCredentials”属性，XmlHttpRequest将仅在跨域请求上发送cookie; 这也会导致预检请求。
   - 需要基于cookie的身份验证的服务必须使用“动态验证码（dynamic canary）” [*]译者注：服务器生成某种验证码，客户端获取后，服务器再进行验证的操作。来保护所有接受cookie的API。
- 对于POST调用，在适用的情况下，选择简单的内容类型(“application/x-www-form-urlencoded”、“multipart/form-data”、“text/plain”)。其他任何内容类型都会引发预检请求。
	- 服务不得以避免CORS预检请求的名义违反其他API指南。由于内容类型的原因，大多数POST请求实际上需要预检请求。
	- 如果非要取消预检工作，那么服务支持的其他的替代数据传输机制必须遵循本指南。

此外，当适当的服务可以支持JSONP模式时，只需简单的GET跨域访问。
在JSONP中，服务采用指示格式的参数(_$format=json_)和表示回调的参数(_$callback=someFunc_)，并返回一个 text/javascript 文档，其中包含用指定名称封装在函数调用中的JSON响应。
更多关于JSONP的信息，请访问Wikipedia: [JSONP](https://en.wikipedia.org/wiki/JSONP)。

## 9. 集合 Collections
### 9.1. Item keys
服务可以支持集合中每个项的持久标识符(主键)，该标识符应用JSON表示为"id" , 这些持久标识符通常用作项目的key。

支持持久标识符(主键)的集合可以支持增量查询。

### 9.2. 序列化 Serialization
集合使用标准数组表示法以JSON表示。

### 9.3. Collection URL patterns 集合的URL匹配
集合在顶级时直接位于服务的根目录下，或者作用于该资源时作为另一个资源下的段。

例如:
```http
GET https://api.contoso.com/v1.0/people
```

服务必须尽可能支持“/” 匹配。
例如:

```http
GET https://{serviceRoot}/{collection}/{id}
```

Where:
- {serviceRoot} – 站点URL (site URL) + 服务的根路径的组合
- {collection} – 集合的名称，未缩写，复数
- {id} – 唯一id属性的值. 当使用 "/" 匹配必须属于 string/number/guid value 不带引号，转义正确以适应URL。

#### 9.3.1. 嵌套集合和属性 Nested collections and properties
集合项可以包含其他集合。
例如，用户集合可能包含多个地址的用户资源:
```http
GET https://api.contoso.com/v1.0/people/123/addresses
```

```json
{
  "value": [
    { "street": "1st Avenue", "city": "Seattle" },
    { "street": "124th Ave NE", "city": "Redmond" }
  ]
}
```

### 9.4. 大集合 Big collections 
随着数据的增长，集合也在增长。所以计划采用分页对所有服务都很重要。
因此，当数据包含多页时，序列化有效负载(payload)必须适当地包含下一页的不透明URL。
有关详细信息，请参阅分页指南。

客户端必须能够恰当的处理请求返回的任何给定的分页或非分页集合数据。

```json
{
  "value":[
    { "id": "Item 1","price": 99.95,"sizes": null},
    { … },
    { … },
    { "id": "Item 99","price": 59.99,"sizes": null}
  ],
  "@nextLink": "{opaqueUrl}"
}
```

### 9.5. Changing collections
POST请求不是幂等的。
这意味着发送到具有完全相同的有效负载(payload)的集合资源的两次POST请求可能导致在该集合中创建多个项。
[*]译者注：相同的数据两次POST操作，可能导致该集合创建多次。
例如，对于具有服务器端生成的id的项的插入操作，通常就是这种情况。

例如，以下请求:
```http
POST https://api.contoso.com/v1.0/people
```

会导致响应，指示新集合项的位置：

```http
201 Created
Location: https://api.contoso.com/v1.0/people/123
```

一旦再次执行，可能会导致创建另一个资源：

```http
201 Created
Location: https://api.contoso.com/v1.0/people/124
```

而PUT请求则需要使用相应的键来指示集合项:
```http
PUT https://api.contoso.com/v1.0/people/123
```

### 9.6. Sorting collections
可以基于属性值对集合查询的结果进行排序。
该属性由_$orderBy_查询参数的值确定。

_$orderBy_ 参数的值包含用于对项目进行排序表达式列表，用逗号分隔的。
这种表达式的特殊情况是属性路径终止于基本属性。

表达式可以包含升序的后缀“asc”或降序的后缀“desc”，它们与属性名之间用一个或多个空格分隔。
如果没有指定“asc”或“desc”，则服务必须按照指定的属性以升序排序。

空值(NULL)必须排序为“小于”非空值。

必须根据第一个表达式的结果值对项进行排序，然后根据第二个表达式的结果值对第一个表达式具有相同值的项进行排序，以此类推。
排序顺序是属性类型的固有顺序。

例如：
```http
GET https://api.contoso.com/v1.0/people?$orderBy=name
```

将返回按name进行升序排序的所有人员。

```http
GET https://api.contoso.com/v1.0/people?$orderBy=name desc
```

将返回按name进行降序排序的所有人。

可以通过逗号分隔的属性名称列表以及可选方向限定符来指定子排序。

例如：

```http
GET https://api.contoso.com/v1.0/people?$orderBy=name desc,hireDate
```

将返回按姓名降序排列的所有人员，并按雇佣日期降序排列的次要排序。

排序必须与筛选相结合，如下:

```http
GET https://api.contoso.com/v1.0/people?$filter=name eq 'david'&$orderBy=hireDate
```

将返回所有名称为David的人，按雇佣日期按升序排列。

#### 9.6.1. Interpreting a sorting expression
跨页面的排序参数必须一致，因为客户端和服务器端分页都依赖该排序该参数进行排序。

如果服务不支持按_$orderBy_表达式中命名的属性排序，则服务必须按照“响应不支持的请求”部分中定义的错误消息进行响应。

### 9.7. Filtering
$filter_querystring 参数允许客户端通过URL过滤集合。
使用_$filter_指定的表达式将为集合中的每个资源求值，只有表达式求值为true的项才包含在响应中。
表达式计算为false或null的资源，或由于权限而不可用的引用属性，将从响应中省略。

例如:返回所有产品的价格低于10.00美元

```http
GET https://api.contoso.com/v1.0/products?$filter=price lt 10.00
```

$filter_选项的值是 一个布尔表达式 表示 price less than 10.00。

#### 9.7.1. Filter operations
支持_$filter_的服务应该支持以下最小操作集。

Operator             | Description           | Example
-------------------- | --------------------- | -----------------------------------------------------
Comparison Operators |                       |
eq                   | Equal                 | city eq 'Redmond'
ne                   | Not equal             | city ne 'London'
gt                   | Greater than          | price gt 20
ge                   | Greater than or equal | price ge 10
lt                   | Less than             | price lt 20
le                   | Less than or equal    | price le 100
Logical Operators    |                       |
and                  | Logical and           | price le 200 and price gt 3.5
or                   | Logical or            | price le 3.5 or price gt 200
not                  | Logical negation      | not price le 3.5
Grouping Operators   |                       |
( )                  | Precedence grouping   | (priority eq 1 or city eq 'Redmond') and price gt 100

#### 9.7.2. Operator examples
下面的示例说明了每个逻辑操作符的用法和语义。

示例:所有名称等于“Milk”的产品

```http
GET https://api.contoso.com/v1.0/products?$filter=name eq 'Milk'
```

示例:所有名称不等于“Milk”的产品

```http
GET https://api.contoso.com/v1.0/products?$filter=name ne 'Milk'
```

示例:所有标有“Milk”的产品价格都低于2.55:

```http
GET https://api.contoso.com/v1.0/products?$filter=name eq 'Milk' and price lt 2.55
```

示例:所有标有“Milk”字样或价格低于2.55美元的产品:

```http
GET https://api.contoso.com/v1.0/products?$filter=name eq 'Milk' or price lt 2.55
```

示例:所有名称为“牛奶”或“鸡蛋”且价格低于2.55的产品:

```http
GET https://api.contoso.com/v1.0/products?$filter=(name eq 'Milk' or name eq 'Eggs') and price lt 2.55
```

#### 9.7.3. Operator precedence
在计算_$filter_表达式时，服务使用以下操作符优先级。
操作符按类别按优先级从高到低排列。
同一类别的运算符具有同等优先级:
| Group           | Operator | Description           |
|:----------------|:---------|:----------------------|
| Grouping        | ( )      | Precedence grouping   |
| Unary           | not      | Logical Negation      |
| Relational      | gt       | Greater Than          |
|                 | ge       | Greater than or Equal |
|                 | lt       | Less Than             |
|                 | le       | Less than or Equal    |
| Equality        | eq       | Equal                 |
|                 | ne       | Not Equal             |
| Conditional AND | and      | Logical And           |
| Conditional OR  | or       | Logical Or            |

### 9.8. Pagination
返回集合的RESTful API可能返回部分集。
这些服务的消费者清楚将获得部分结果集，并能正确地翻页以检索整个结果集。

RESTful API可能支持两种形式的分页。
服务器驱动的分页：通过在多个响应有效载荷上强制分页请求来减轻拒绝服务攻击。
客户端驱动的分页：允许客户机只请求它在给定时间可以使用的资源数量。

跨页面的排序和筛选参数必须一致，因为客户端和服务器端分页都完全兼容于筛选和排序。

#### 9.8.1. Server-driven paging
分页响应必须通过在响应中包含延续分页标记来告诉客户端这是部分结果。
没有延续分页标记意味着没有下一页了。

客户端必须将延续URL视为不透明的，这意味着在迭代一组部分结果时，查询选项可能不会更改。

例如:

```http
GET http://api.contoso.com/v1.0/people HTTP/1.1
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  ...,
  "value": [...],
  "@nextLink": "{opaqueUrl}"
}
```

#### 9.8.2. Client-driven paging
客户端可以使用_$top_和_$skip_查询参数来指定返回的结果数量和跳过的集合数量。

服务器应遵守客户端指定的参数; 但是，客户端必须做好准备处理包含不同页面大小的响应或包含延续分页标记的响应。

当客户端同时提供_$top_和_$skip_时，服务器应该首先应用_$skip_，然后对集合应用_$top_。

注意:如果服务器不能执行_$top_和/或_$skip_，服务器必须返回一个错误给客户端，告知它，而不是忽略该查询参数。
这将避免客户端对返回的数据做出假设的风险。

实例:

```http
GET http://api.contoso.com/v1.0/people?$top=5&$skip=2 HTTP/1.1
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  ...,
  "value": [...]
}
```

#### 9.8.3. Additional considerations
**固定的顺序先决条件:**两种分页形式都依赖于具有固定顺序的项的集合。
服务器必须使用额外的排序(通常是按键排序)来补充任何指定的顺序标准，以确保项目始终保持一致的顺序。

**缺失/重复结果：**即使服务器强制执行一致的排序顺序，结果也可能会因创建或删除其他资源而导致丢失或重复。
客户端必须准备好处理这些差异。
服务器应该总是编码最后读取记录的记录ID，帮助客户端管理重复/丢失的结果。

**结合客户端和服务驱动的分页：**请注意，客户端驱动的分页不排除服务器驱动的分页。
如果客户端请求的页面大小大于服务器支持的默认页面大小，则预期响应将是客户端指定的结果数，否则按服务端分页设置的指定分页。

**页面大小：**客户端可以通过指定_$maxpagesize_首选项来请求具有特定页面大小的服务端驱动的分页。
如果指定的页面大小小于服务端的默认页面大小，服务器应该遵循此首选项。

**分页嵌入式集合：**客户端驱动的分页和服务端驱动的分页都可以应用于嵌入式集合。
如果服务端对嵌入式集合进行分页，则必须包含其他适当的延续分页标记。

**记录集计数：**想要知道所有页面中的完整记录数的开发人员可以包含查询参数_$ count=true_，以告知服务端包含响应中的记录数。

### 9.9. Compound collection operations
筛选、排序和分页操作都可以针对给定的集合执行。
当这些操作一起执行时，评估顺序必须是:

1. **筛选**。 这包括作为AND操作执行的所有范围表达式。
2. **排序**。 可能已过滤的列表根据排序条件进行排序。
3. **分页**。 经过筛选和排序的列表上显示了实现分页视图。这适用于服务器驱动的分页和客户端驱动的分页。

## 10. 增量查询 Delta queries
服务可以选择支持Delta查询。
[*]译者注：增量查询可以使客户端能够发现新创建、更新或者删除的实体，无需使用每个请求对目标资源执行完全读取。这让客户端的调用更加高效。  

### 10.1. 增量链接 Delta links
增量(Delta)链接是不透明的、由服务生成的链接，客户端使用这些链接查询对结果的后续更改。

在概念层面上，delta链接基于一个定义查询，该查询描述正在跟踪更改的一组结果集。
delta链接编码并跟踪这些更改的实体集合，以及跟踪更改的起点。

如果查询包含筛选器，则响应必须只包含对匹配指定条件的实体的更改。
Delta查询的主要原则是:

- 集合中的每个项目必须具有持久标识符（永久不变的主键）。该标识符应该表示为“id”。 此标识符由服务定义，客户端可以使用该字符串跨调用跟踪对象。
- delta 必须包含每个与指定条件新匹配的实体的条目，并且必须为每个不再符合条件的实体包含“@removed”条目。
- 重新调用查询并将其与原始结果集进行比较; 必须将当前集合中惟一的每个条目作为"add"操作返回，并且必须将原始集合中惟一的每个条目作为“remove”操作返回。。
- 以前与标准不匹配但现在匹配的每个实体必须作为"add"返回; 相反，先前与查询匹配但不再必须返回的每个实体必须作为“@removed”条目返回。
- 已更改的实体必须使用其标准表示形式包含在集合中。
- 服务可以向“@remove”节点添加额外的元数据，例如删除的原因或“removed at”时间戳。我们建议团队与Microsoft REST API指导原则工作组协调，以帮助维护一致性。

Delta链接不能编码任何客户端 top 或 skip 值。

### 10.2. Entity representation
添加和更新的实体使用其标准表示在实体集中表示。
从集合的角度来看，添加或更新的实体之间没有区别。

删除的实体仅使用其“id”和“@removed”节点表示。
“@removed”节点的存在必须表示从集合中删除条目。

### 10.3. Obtaining a delta link
通过查询集合或实体并附加 $delta 查询字符串参数来获得 Delta 链接。

例如：
```http
GET https://api.contoso.com/v1.0/people?$delta
HTTP/1.1
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "value":[
    { "id": "1", "name": "Matt"},
    { "id": "2", "name": "Mark"},
    { "id": "3", "name": "John"}
  ],
  "@deltaLink": "{opaqueUrl}"
}
```

注意:如果集合分页，deltaLink将只出现在最后一页，但必须反映对所有页面返回的数据的任何更改。

### 10.4. Contents of a delta link response
添加/更新的条目必须以常规JSON对象的形式出现，并带有常规项目属性。
在常规表示中返回添加/修改的项，允许客户端使用基于“id”字段的标准合并概念将它们合并到现有的“缓存”中。

从定义的集合中删除的条目必须包含在响应中。
从集合中删除的项必须仅使用它们的“id”和“@remove”节点表示。

### 10.5. Using a delta link
客户端通过调用delta链接上的GET方法请求更改。
客户端必须按原样使用delta URL——换句话说，客户端不能以任何方式修改URL(例如，解析URL并添加额外的查询字符串参数)。

在这个例子中:

```http
GET https://{opaqueUrl} HTTP/1.1
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "value":[
    { "id": "1", "name": "Mat"},
    { "id": "2", "name": "Marc"},
    { "id": "3", "@removed": {} },
    { "id": "4", "name": "Luc"}
  ],
  "@deltaLink": "{opaqueUrl}"
}
```

针对delta链接的请求的结果可以跨多个页面，但是必须由服务跨所有页面进行排序，以便在应用到包含delta链接的响应时确保得到确定的结果。

如果没有发生任何更改，则响应是一个空集合，其中包含一个delta链接，用于根据请求进行后续更改。
这个delta链接可能与delta链接相同，从而导致更改的空集合。

如果delta链接不再有效，则服务必须使用_410 Gone_响应。响应应该包含一个Location头，客户端可以使用它来检索新的基线结果集。

## 11. JSON standardizations
### 11.1. JSON formatting standardization for primitive types
必须按照[RFC8259] [rfc-8259]的规则将原始值序列化为JSON。

** 64位整数的重要说明：** JavaScript将静默截断大于“Number.MAX_SAFE_INTEGER”（2 ^ 53-1）的整数或小于“Number.MIN_SAFE_INTEGER”（-2 ^ 53 + 1）的数字。 
** 如果预期服务返回超出安全值范围的整数值，请强烈考虑将该值作为字符串返回，以便最大化互操作性并避免数据丢失。

### 11.2. Guidelines for dates and times
#### 11.2.1. Producing dates
服务必须使用“DateLiteral”格式生成日期，并且应该使用“Iso8601Literal”格式，除非有令人信服的理由不这样做。
使用“StructuredDateLiteral”格式的服务绝不能使用“T”类型生成日期，除非需要额外的精度，并且明确不支持ECMAScript客户端。
(非规范性陈述:当决定要标准化哪一种特定的“日期类型（DateKind）”时，偏好的大致顺序是“E, C, U, W, O, X, I, T”。
这是对ECMAScript、.NET和c++程序员的优化，按顺序排列)。

#### 11.2.2. Consuming dates
服务必须接受来自使用相同`DateLiteral`格式（包括它们生成的`DateKind`，如果适用）的客户的日期，并且应该使用任何`DateLiteral`格式接受日期。

#### 11.2.3. Compatibility
服务必须对相同类型的所有资源使用相同的`DateLiteral`格式（包括相同的`DateKind`，如果适用），并且应该对所有资源使用相同的`DateLiteral`格式（和`DateKind`，如果适用） 整个服务。

服务生成的`DateLiteral`格式的任何更改（包括`DateKind`，如果适用）和服务所接受的`DateLiteral`格式（和DateKind`，如果适用）的任何缩减都必须被视为破坏性的更改。
任何被服务接受的“DateLiteral”格式的扩展都不会被认为是破坏性的更改。

### 11.3. JSON serialization of dates and times
使用JSON往返序列化日期是一个难题。
尽管ECMAScript支持大多数内置类型的文字，但它没有为日期定义文字格式。
Web已经围绕着[ISO 8601日期格式(ISO 8601)的ECMAScript子集][ISO -8601] [ISO -8601进行了合并，但是在某些情况下，这种格式是不可取的。
对于这些情况，本文档定义了一个JSON序列化格式，可用于明确表示不同格式的日期。
其他序列化格式(如XML)可以从这种格式派生出来。

#### 11.3.1. The `DateLiteral` format 
使用以下语法对JSON中表示的日期进行序列化。
非正式地，`DateValue`是ISO 8601格式的字符串或JSON对象，它包含两个名为`kind`和`value`的属性，它们共同定义了一个时间点。

下面的语法不是上下文无关的; 特别是，`DateValue`的解释取决于`DateKind`的值，但这将描述格式所需的产品数量降到最低。

```
DateLiteral:
  Iso8601Literal
  StructuredDateLiteral

Iso8601Literal:
  A string literal as defined in http://www.ecma-international.org/ecma-262/5.1/#sec-15.9.1.15. Note that the full grammar for ISO 8601 (such as "basic format" without separators) is not supported.
  All dates default to UTC unless specified otherwise.

StructuredDateLiteral:
  { DateKindProperty , DateValueProperty }
  { DateValueProperty , DateKindProperty }

DateKindProperty
  "kind" : DateKind

DateKind:
  "C"            ; see below
  "E"            ; see below
  "I"            ; see below
  "O"            ; see below
  "T"            ; see below
  "U"            ; see below
  "W"            ; see below
  "X"            ; see below

DateValueProperty:
  "value" : DateValue

DateValue:
  UnsignedInteger        ; not defined here
  SignedInteger        ; not defined here
  RealNumber        ; not defined here
  Iso8601Literal        ; as above
```

#### 11.3.2. Commentary on date formatting
使用“Iso8601Literal”生产的“DateLiteral”相对简单。
下面是一个名为“creationDate”的对象的例子，该对象的属性设置为2015年2月13日下午1:15 UTC:

```json
{ "creationDate" : "2015-02-13T13:15Z" }
```

“StructuredDateLiteral”由一个“DateKind”和一个“DateValue”组成，其有效值(及其解释)取决于“DateKind”。下表描述了有效的组合及其意义:

DateKind | DateValue       | Colloquial Name & Interpretation                                                                                                                  | More Info
-------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------
C        | UnsignedInteger | "CLR"; number of milliseconds since midnight January 1, 0001; negative values are not allowed. *See note below.*                                  | [MSDN][clr-time]
E        | SignedInteger   | "ECMAScript"; number of milliseconds since midnight, January 1, 1970.                                                                             | [ECMA International][ecmascript-time]
I        | Iso8601Literal  | "ISO 8601"; a string limited to the ECMAScript subset.                                                                                            |
O        | RealNumber      | "OLE Date"; integral part is the number of days since midnight, December 31, 1899, and fractional part is the time within the day (0.5 = midday). | [MSDN][ole-date]
T        | SignedInteger   | "Ticks"; number of ticks (100-nanosecond intervals) since midnight January 1, 1601. *See note below.*                                             | [MSDN][ticks-time]
U        | SignedInteger   | "UNIX"; number of seconds since midnight, January 1, 1970.                                                                                        | [MSDN][unix-time]
W        | SignedInteger   | "Windows"; number of milliseconds since midnight January 1, 1601. *See note below.*                                                               | [MSDN][windows-time]
X        | RealNumber      | "Excel"; as for `O` but the year 1900 is incorrectly treated as a leap year, and day 0 is "January 0 (zero)."                                     | [Microsoft Support][excel-time]

**注意“C”和“W”类型:**本机CLR和Windows时间由100纳秒的“滴答”值表示。
要与精度有限的ECMAScript客户端进行互操作，必须将这些值转换为毫秒，并在(反)序列化为“DateLiteral”时从毫秒转换为毫秒。
1毫秒相当于10,000 ticks。

**对于`T`类的重要说明：**这种类型保留了Windows本机时间格式的完全保真度（并且可以轻松转换为本机CLR格式），但与ECMAScript客户端不兼容。
因此，它的使用应该仅限于那些既需要额外精度又不需要与ECMAScript客户端互操作的场景。

以下是具有名为creationDate的属性的对象的相同示例，该属性设置为2015年2月13日下午1:15. UTC，使用多种格式：

```json
[
  { "creationDate" : { "kind" : "O", "value" : 42048.55 } },
  { "creationDate" : { "kind" : "E", "value" : 1423862100000 } }
]
```

将类型与值分开的一个好处是，一旦客户端知道特定服务使用的类型，它就可以很容易的解释该值。
在值为数字的常见情况下，这使开发人员更容易编码：

```csharp
// We know this service always gives out ECMAScript-format dates
var date = new Date(serverResponse.someObject.creationDate.value);
```

### 11.4. Durations
[持续时间] [wikipedia-iso8601-durations]需要按照[ISO 8601] [wikipedia-iso8601-durations]进行序列化。
持续时间“由格式'P [n] Y [n] M [n] DT [n] H [n] M [n] S`表示。”
从标准：
 -  P是在持续时间表示开始时放置的持续时间指示符（历史上称为“时段”）。
 -  Y是年份指示符，它遵循年数值。
 -  M是月份指示符，它遵循月数值。
 -  W是周指示符，它遵循周数值。
 -  D是遵循天数值的日期指示符。
 -  T是在表示的时间分量之前的时间指示符。
 -  H是小时指示符，它遵循小时数值。
 -  M是遵循分钟数值的分钟指示符。
 -  S是秒指示符，它遵循秒数的值。

例如，“P3Y6M4DT12H30M5S”表示“三年，六月，四天，十二小时，三十分钟和五秒”的持续时间。

### 11.5. Intervals
[间隔] [wikipedia-iso8601-intervals]被定义为[ISO 8601] [wikipedia-iso8601-intervals]的一部分。
 - 开始和结束，例如“2007-03-01T13：00：00Z / 2008-05-11T15：30：00Z”
 - 开始和持续时间，例如“2007-03-01T13：00：00Z / P1Y2M10DT2H30M”
 - 持续时间和结束，例如“P1Y2M10DT2H30M / 2008-05-11T15：30：00Z”
 - 仅限持续时间，例如“P1Y2M10DT2H30M”，以及其他上下文信息

### 11.6. Repeating intervals
根据[ISO 8601] [wikipedia-iso8601-repeatingintervals]，[重复间隔] [wikipedia-iso8601-repeatingintervals]是：

>通过在区间表达式的开头添加“R [n] /”形成，其中R用作字母本身，[n]用重复次数代替。
省略[n]的值意味着无限次重复。

例如，要从“2008-03-01T13：00：00Z”开始重复“P1Y2M10DT2H30M”的间隔五次，请使用“R5 / 2008-03-01T13：00：00Z / P1Y2M10DT2H30M”。

## 12. Versioning
**所有符合Microsoft REST API准则的API都必须支持显式版本控制。
**客户端可以指望服务随着时间的推移保持稳定至关重要，服务可以添加功能和进行更改至关重要。

### 12.1. Versioning formats
服务使用Major.Minor版本控制方案进行版本控制。
服务可以选择“主要”版本方案，在这种情况下标注为 “.0”，适用于本节中的所有其他规则。
支持指定REST API请求版本的两个选项：
 - 嵌入在请求URL的路径中，位于服务根目录的末尾：`https://api.contoso.com/v1.0/products/users`
 - 作为URL的查询字符串参数：`https://api.contoso.com/products/users?api-version=1.0`

选择两种方案的指导如下：
1.位于DNS端点后面的服务必须使用相同的版本控制机制。
2.在此方案中，跨端点的一致用户体验至关重要。 Microsoft REST API准则工作组建议，如果没有与组织的领导团队进行明确的对话，则不会创建新的顶级DNS端点。
3.即使通过API的未来版本，保证REST API的URL路径稳定性的服务也可以采用查询字符串参数机制。 这意味着API中描述的关系的命名和结构在API发布后无法再进行变化，即使在具有重大更改的版本中也是如此。
4.无法确保未来版本的URL路径稳定性的服务必须将该版本嵌入到URL路径中。

[编者注：]本处的TDL(top-level DNS endpoints)意思是指 https://api.contoso.com 这个api的域名，没有必要的话不要新增域名的方式来新增版本。

某些基础服务（如Microsoft的Azure Active Directory）可能会被部署在多个端点之后。
所以服务必须支持每个端点的版本控制机制，即使这意味着支持多种版本控制机制。

#### 12.1.1. Group versioning
组版本控制是一种可选功能，可以使用查询字符串参数机制在服务上提供。
组版本允许在公共版本控制名称下对API端点进行逻辑分组。
这允许开发人员查找单个版本号并在多个端点上使用它。
组版本号是众所周知的，服务应该拒绝任何无法识别的值。

在内部，服务将采用组版本并将其映射到相应的Major.Minor版本。

组版本格式定义为YYYY-MM-DD，例如2012-12-07 2012年12月7日。此日期版本控制格式仅适用于组版本，不应该用作Major.Minor版本控制的替代版本。

[*]译者注：API然后想着对用户长期保持不变，那确实很麻烦，可以选择按版本控制或者按日期控制，下面例子按日期进行分组，意思就是把次要的版本映射到某个组（日期）里面去。

##### 组版本控制实例

##### Examples of group versioning

| Group      | Major.Minor |
|:-----------|:------------|
| 2012-12-01 | 1.0         |
|            | 1.1         |
|            | 1.2         |
| 2013-03-21 | 1.0         |
|            | 2.0         |
|            | 3.0         |
|            | 3.1         |
|            | 3.2         |
|            | 3.3         |

Version Format                | Example                | Interpretation
----------------------------- | ---------------------- | ------------------------------------------
{groupVersion}                | 2013-03-21, 2012-12-01 | 3.3, 1.2
{majorVersion}                | 3                      | 3.0
{majorVersion}.{minorVersion} | 1.2                    | 1.2

客户端可以指定组版本或Major.Minor版本：

实例：
```http
GET http://api.contoso.com/acct1/c1/blob2?api-version=1.0
```

```http
PUT http://api.contoso.com/acct1/c1/b2?api-version=2011-12-07
```

### 12.2. When to version
服务必须增加其版本号以响应任何中断的API更改。
有关如何构成重大变更的详细讨论，请参阅以下部分。
如果需要，服务也可以增加它们的版本号来进行非中断更改。

使用新的主要版本号表示将来不推荐对现有客户端的支持。
在引入新的主要版本时，服务必须为现有客户提供明确的升级路径，并制定与其业务组策略一致的弃用计划。
服务应该为所有其他更改使用新的次要版本号。

版本化服务的在线文档必须指出每个先前API版本的当前支持状态，并提供最新版本的路径。

### 12.3. Definition of a breaking change
对API契约(约定)的更改被认为是破坏性的更改。
影响API向后兼容性的更改是破坏性的更改。

团队可以根据业务需求定义向后兼容性。
例如，Azure在响应中定义了一个新的JSON字段，使其不向后兼容。
Office 365对向后兼容性的定义更宽松，允许将JSON字段添加到响应中。

破坏性改变的明显例子：
1.删除或重命名API或API参数
2.现有API的行为更改
3.错误代码和故障合同的变化
4.任何违反[最少惊动原则] [principle-of-least-astonishment]的事情

服务必须明确定义它们对重大变化的定义，特别是关于向JSON响应添加新字段和使用默认字段添加新API参数。
与其他服务共存于DNS端点后面的服务必须在定义合同可扩展性方面保持一致。

[OData V4规范的这一部分]描述的适用变更[odata-breaking-changes]应该被视为所有服务必须考虑突破性变化的最小标准的一部分。

## 13. Long running operations
长时间运行的操作（有时称为异步操作）往往对不同的人意味着不同的事情。
本节介绍了围绕不同类型的长时间运行操作的指南，并描述了这些类型的操作的线路协议和最佳实践。

1.一个或多个客户端必须能够同时监视和操作相同的资源。
2.系统的状态应该始终是可发现和可测试的。即使操作跟踪资源不再处于活动状态，客户端也应该能够确定系统状态。查询长期运行状态的行为本身应该遵循web原则：即具有统一接口语义的定义良好的资源。客户端可以在某些资源上发出GET以确定长时间运行的状态
3.长时间运行的操作应该适用于希望“解雇并忘记”的客户，以及希望积极监控结果并根据结果采取行动的客户。
4.取消并不明确意味着回滚。在每个API定义的情况下，它可能意味着回滚，或补偿，或完成，或部分完成等。在取消操作后，客户不应将服务返回到允许继续服务的一致状态。

[*]译者注：如果准备操作某种长时间运行的资源（设备或者作业）,如更新某物联网设备ip，这会导致此物联网设备重启或者掉线后重连，这中间的状态是不可控的，本节主要是说明如何对这种情况进行处理。

### 13.1. Resource based long running operations (RELO)
基于资源的建模是将操作的状态编码在资源中，使用的wire协议是标准同步协议。
在这个模型中，状态转换被很好地定义，目标状态也被类似地定义。

_这是长期运行操作的首选模型，应该尽可能使用 ._ 避免LRO Wire协议的复杂性和机制使我们的用户和工具链更加简单。

一个示例：计算机重新启动，该操作本身同步完成，但虚拟机资源上的GET操作将可以随时查询，如下状态：“状态：重新启动”，“状态：正在运行”。

该模型可以集成推送通知。

虽然大多数操作可能是POST语义，但除了POST语义之外，服务可以通过路由支持PUT语义以简化其API。
例如，想要创建名为“db1”的数据库的用户可以调用：

```http
PUT https://api.contoso.com/v1.0/databases/db1
```

在这种情况下，数据库端正在处理PUT操作。

服务也可以使用下面定义的混合。

### 13.2. 分阶段的长时间运行的操作
分阶段操作需要很长时间，而且通常是不可预测的完成时间，并且不提供在资源中建模的状态转换。
本节概述了服务应该用于显示这种长时间运行的操作的方法。

服务可以显示逐步操作。

>分阶段长时间运行的操作有时称为“异步”操作。
这会导致混淆，因为它将平台的元素(“Async/waiting”、“promises”、“futures”)与API操作的元素混合在一起。
本文档使用术语“分阶段长时间运行的操作”，或者通常只是“分阶段操作”，以避免混淆“异步”一词。

服务必须对分阶段请求执行尽可能多的同步验证。
服务必须以同步方式对返回错误进行优先级排序，其目标是仅使用长时间运行的操作线协议处理“有效”操作。

对于定义为分阶段长时间运行的操作的API，即使操作可以立即完成，服务也必须经过分阶段长时间运行的操作流。
换句话说，api必须采用并坚持LRO模式，而不是根据环境改变模式。

#### 13.2.1. PUT
服务可以支持实体创建的PUT请求。

```http
PUT https://api.contoso.com/v1.0/databases/db1
```

在这个场景中，_databases_段正在处理PUT操作。

```http
HTTP/1.1 202 Accepted
Operation-Location: https://api.contoso.com/v1.0/operations/123
```

对于需要返回此处创建的201的服务，请使用下面描述的混合流。

202 Accepted应该不返回任何身体。
201 Created案例应该返回目标资源的主体。

#### 13.2.2. POST
服务可以为实体创建启用POST请求。

```http
POST https://api.contoso.com/v1.0/databases/

{
  "fileName": "someFile.db",
  "color": "red"
}
```

```http
HTTP/1.1 202 Accepted
Operation-Location: https://api.contoso.com/v1.0/operations/123
```

#### 13.2.3. POST, hybrid model
即使在生成响应时未完全创建资源，服务也可以同步响应对创建资源的集合的POST请求。
为了使用这种模式，响应必须包括不完整资源的表示以及它不完整的指示。

例如：
```http
POST https://api.contoso.com/v1.0/databases/ HTTP/1.1
Host: api.contoso.com
Content-Type: application/json
Accept: application/json

{
  "fileName": "someFile.db",
  "color": "red"
}
```

服务响应 表示已经创建了数据库，但是通过包含操作位置头表示请求还没有完成。
在这种情况下，响应有效负载中的status属性还指示操作尚未完全完成。

```http
HTTP/1.1 201 Created
Location: https://api.contoso.com/v1.0/databases/db1
Operation-Location: https://api.contoso.com/v1.0/operations/123

{
  "databaseName": "db1",
  "color": "red",
  "Status": "Provisioning",
  [ … other fields for "database" …]
}
```

#### 13.2.4. Operations resource
服务可以在租户级别提供“/操作”资源。

提供“/operations”资源的服务 必须提供GET语义。
GET必须按照标准的分页、排序和过滤语义枚举一组操作。
该操作的默认排序顺序必须是:

Primary Sort           | Secondary Sort
---------------------- | -----------------------
Not Started Operations | Operation Creation Time
Running Operations     | Operation Creation Time
Completed Operations   | Operation Creation Time

注意，“已完成的操作”是一个目标状态(见下文)，并且可能实际上是几个不同状态中的任意一个，比如“成功”、“取消”、“失败”等等。

#### 13.2.5. Operation resource
操作是一个用户可寻址的资源，它跟踪一个逐步长时间运行的操作。
操作必须支持GET语义。
针对操作的GET操作必须返回:

1. 操作资源，它的状态，以及与特定API相关的任何扩展状态。
2. 200 OK作为响应代码。

服务可以通过在操作上公开DELETE来支持操作取消。
如果支持删除操作，则删除操作必须是幂等的。

>注意：从API设计的角度来看，取消并不明确意味着回滚。

在每个API定义的情况下，它可能意味着回滚，补偿，完成或部分完成等。
在取消操作后，客户不应将服务返回到允许继续服务的一致状态。

不支持操作取消的服务必须在DELETE事件中返回405 Method Not Allowed。

操作必须支持下列状态:

1. 没有开始(NotStarted)
2. 运行(Running)
3. 成功了。终端状态(Succeeded. Terminal State)
4. 失败了。终端状态(Failed. Terminal State)

服务可以添加其他状态，例如“已取消”或“部分完成”。 支持取消的服务必须充分描述其取消，以便能够准确地确定系统的状态，并且可以运行任何补偿动作。

支持其他状态的服务应考虑此规范名称列表，并尽可能避免创建新名称：取消中(Cancelling)，取消(Cancelled)，中止中(Aborting)，中止(Aborted)，逻辑删除(Tombstone)，删除中(Deleting)，删除(Deleted)。

操作必须包含并在GET响应中提供以下信息:
1. 创建操作时的时间戳。
2. 输入当前状态的时间戳。
3. 操作状态(未启动/运行/完成)。

服务可以向操作中添加附加的特定于API的字段。
返回的操作状态JSON如下:

```json
{
  "createdDateTime": "2015-06-19T12-01-03.45Z",
  "lastActionDateTime": "2015-06-19T12-01-03.45Z",
  "status": "notstarted | running | succeeded | failed"
}
```

##### Percent complete
有时，服务不可能准确地知道操作何时完成。
这使得使用回车后标头有问题。
在这种情况下，服务可能在operationStatus JSON中包含一个百分比完成字段。

```json
{
  "createdDateTime": "2015-06-19T12-01-03.45Z",
  "percentComplete": "50",
  "status": "running"
}
```

在本例中，服务器向客户机表明，长时间运行的操作已经完成了50%。

##### Target resource location
对于导致或操作资源的操作，服务必须在操作完成时将目标资源位置包含在状态中。

```json
{
  "createdDateTime": "2015-06-19T12-01-03.45Z",
  "lastActionDateTime": "2015-06-19T12-06-03.0024Z",
  "status": "succeeded",
  "resourceLocation": "https://api.contoso.com/v1.0/databases/db1"
}
```

#### 13.2.6. Operation tombstones
服务可以选择支持逻辑删除操作。
服务可以选择在服务定义的时间段之后删除tombstone。

#### 13.2.7. The typical flow, polling
- Client通过使用POST调用来分阶段操作
- 服务器必须通过使用 202 Accepted 状态码来响应请求，从而表明该请求已经启动。响应应该包括包含URL的位置标头，客户端应该在等待 Retry-After 标头中指定的秒数后轮询结果。
- 客户端轮询该位置，直到收到具有终端操作状态的200响应。

##### Example of the typical flow, polling
客户端重启调用动作：

```http
POST https://api.contoso.com/v1.0/databases HTTP/1.1
Accept: application/json

{
  "fromFile": "myFile.db",
  "color": "red"
}
```

服务器响应表明已创建请求。

```http
HTTP/1.1 202 Accepted
Operation-Location: https://api.contoso.com/v1.0/operations/123
```

客户端等待一段时间然后调用另一个请求以尝试获取操作状态。

```http
GET https://api.contoso.com/v1.0/operations/123
Accept: application/json
```

服务器响应结果仍未准备好，并提供等待30秒的建议(可选操作)。

```http
HTTP/1.1 200 OK
Retry-After: 30

{
  "createdDateTime": "2015-06-19T12-01-03.4Z",
  "status": "running"
}
```

客户端等待建议的30秒，然后调用另一个请求以获取操作结果。

```http
GET https://api.contoso.com/v1.0/operations/123
Accept: application/json
```

服务器以包含资源位置的“状态：成功”操作进行响应。

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "createdDateTime": "2015-06-19T12-01-03.45Z",
  "lastActionDateTime": "2015-06-19T12-06-03.0024Z",
  "status": "succeeded",
  "resourceLocation": "https://api.contoso.com/v1.0/databases/db1"
}
```

#### 13.2.8. The typical flow, push notifications
1.客户端通过使用POST调用操作来调用长时间运行的操作。 客户端已在父资源上设置了推送通知。
2.服务通过响应202 Accepted状态代码表示请求已启动。 客户忽略了其他一切。
3.完成整个操作后，服务通过父资源上的订阅推送通知。
4.客户端通过资源URL检索操作结果。

##### Example of the typical flow, push notifications existing subscription
客户端调用备份操作。
客户端已经为db1提供了推送通知订阅设置。

```http
POST https://api.contoso.com/v1.0/databases/db1?backup HTTP/1.1
Accept: application/json
```

服务器响应表明该请求已被接受。

```http
HTTP/1.1 202 Accepted
Operation-Location: https://api.contoso.com/v1.0/operations/123
```

调用者忽略返回中的所有标头。

操作完成后，目标URL会收到推送通知。

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "value": [
    {
      "subscriptionId": "1234-5678-1111-2222",
      "context": "subscription context that was specified at setup",
      "resourceUrl": "https://api.contoso.com/v1.0/databases/db1",
      "userId" : "contoso.com/user@contoso.com",
      "tenantId" : "contoso.com"
    }
  ]
}
```

#### 13.2.9. Retry-After
在上面的示例中，Retry-After标头指示客户端在尝试从位置标头标识的URL获取结果之前应等待的秒数。

HTTP规范允许Retry-After头指定HTTP日期，因此客户端也应该准备好处理这个问题。

```http
HTTP/1.1 202 Accepted
Operation-Location: http://api.contoso.com/v1.0/operations/123
Retry-After: 60
```

注意:HTTP日期的使用与本文档中使用的ISO 8601日期格式不一致，但是由[RFC 7231][RFC -7231-7-1-1-1]中的HTTP标准明确定义。服务应该选择整数秒(十进制)格式，而不是HTTP日期格式。

### 13.3. Retention policy for operation results
在某些情况下，长时间运行操作的结果不是可以处理的资源。
例如，如果您调用一个返回布尔值(而不是资源)的长时间运行的操作。
在这些情况下，Location头指向可以检索布尔结果的位置。

这就引出了一个问题:“运行的结果应该保留多久?”

建议的最短保留时间为24小时。

在从系统中清除之前，操作应该再过渡到墓碑(tombstone)一段时间。

## 14. 限流, 配额, 和限定
### 14.1. 原则
服务应该尽可能地响应调用，以免阻塞调用者。

根据经验，任何预计在完成最后1%上花费超过0.5秒的API调用 都应该考虑对这些调用使用长时间运行操作模式。

显然，面对来自调用方的潜在的无限负载，服务必然面临无法保证这些响应时间。因此，服务应该为客户端设计和记录调用请求限制，并在超过这些限制时使用适当的、可操作的错误和错误消息进行响应。

当服务通常过载时，它们应该快速响应错误，而不是简单不去处理导致响应缓慢。
最后，许多服务将对调用设置有配额，可能是每小时或每天的操作数，通常与服务计划或价格相关。
当超过这些配额时，服务还必须提供即时的、可操作的错误。
配额和限制的范围应该限定到一个客户单元:订阅、租户、应用程序、计划，或者在没有任何其他标识的情况下，根据服务目标确定一系列ip地址……以便正确地共享负载，并且一个单元不会干扰另一个单元。

### 14.2. 返回HTTP代码 (429 vs 503)
HTTP为这些场景指定了两个返回代码:“429 Too Many Requests”和“503 Service Unavailable”。
服务应该返回 429 来处理客户端调用数过多的情况，并且可以通过更改调用模式来修复这种情况。
如果一般负载或个别调用者无法控制的其他问题导致服务变慢，则服务应使用503进行响应。

在这种情况下，服务还应该提供信息，建议调用者在再次尝试之前应该等待多长时间。
客户端应该尊重服务器返回的这些报头，并实现其他瞬时故障处理技术。
然而，可能有一些客户端在失败后立即重试，这可能会增加服务的负载。
为了处理这个问题，服务的设计应该使返回429或503尽可能不那么消耗服务资源(便宜)，要么输入特殊的快速路径代码，要么理想情况下依赖于提供此功能的公共网管或负载均衡器。

### 14.3. 稍后重试(Retry-After) 和 限制速度标头(RateLimit Headers)
Retry-After报头是响应正在限流的客户端的标准方法。
在限制和配额(但不是整个系统负载)的情况下，使用描述超出限制的头部来响应也是常见的，但也是可选的。
然而，微软和整个行业的服务为此目的使用了各种不同的头文件。
我们建议使用三个头来描述限制、限制下剩余的调用数量以及限制将重置的时间。
但是，其他头可能适合特定类型的限制。不管什么情况下，这些都必须记录下来。


### 14.4. 服务端指南
服务应根据SLA或业务目标选择适合的时间窗口。
在配额的情况下，Retry-After时间和时间窗口可能很长（小时，天，周，甚至几个月。服务使用429表示特定的调用者发出了太多的调用，使用503表示服务正在减少负载，但这不是调用者的责任。

#### 14.4.1. 响应性
1. 服务必须在所有情况下快速响应，即使在负载过多的情况下也是如此。
2. 如果该调用99%响应花费超过1秒应该使用长时间运行模式。
3. 如果该调用99％的响应持续时间超过0.5秒中应该强烈考虑LRO模式。
4. 服务不应该引入阻塞调用者或不可操作的睡眠、暂停等(“tar-pitting”)。

#### 14.4.2. 限速和配额
当呼叫者过多调用（可能是滥用）

1.服务必须返回429代码
2.服务必须返回描述细节的标准错误响应，以便程序员可以进行适当的更改
3.服务必须返回一个Retry-After标头，指示客户端在重试之前应该等待多长时间
4.服务可以返回RateLimit标题，用于记录已超出的限制或配额
5.服务可以返回RateLimit-Limit：客户端允许在时间窗口中进行的调用次数
6.服务可以返回RateLimit-Remaining：时间窗口中剩余的调用数量
7.服务可能返回RateLimit-Reset:窗口重置的时间，以UTC格式 秒为单位
8.服务可以根据需要返回其他特定于服务的RateLimit标头，以获取更多详细信息或特定限制或配额

#### 14.4.3. 服务过载
当服务通常过载和减载时
1.服务必须返回一个503代码
2.服务必须返回一个描述细节的标准错误响应(参见7.10.2)，以便程序员能够做出适当的更改
3.服务必须返回一个Retry-After头文件，该头文件指示客户机在重试之前应该等待多长时间
4.在503情况下，服务不应该返回RateLimit报头

#### 14.4.4. 响应的例子
```http
HTTP/1.1 429 Too Many Requests
Content-Type: application/json
Retry-After: 5
RateLimit-Limit: 1000
RateLimit-Remaining: 0
RateLimit-Reset: 1538152773
{
  "error": {
    "code": "requestLimitExceeded",
    "message": "The caller has made too many requests in the time period.",
    "details": {
      "code": "RateLimit",
       "limit": "1000",
       "remaining": "0",
       "reset": "1538152773",
      }
    }
}
```

### 14.5. 客户端指南
调用者包括API的所有用户:工具、门户、其他服务，而不仅仅是用户客户端

1. 在重试请求之前，调用者必须等待Retry-After响应中指示的最短时间。
2. 调用者可以假设，在接收到带有Retry-After标头的响应之后，再重试请求，而不需要对请求做任何更改。
3. 客户端应该使用共享的sdk和通用的瞬态故障库来实现正确的行为

See: https://docs.microsoft.com/en-us/azure/architecture/best-practices/transient-faults

### 14.6. 处理调用忽略Retry-After标头
理想情况下，429和503返回的成本非常低，甚至可以处理大量立即重试的客户端请求。
在这些情况下，如果可能，服务团队应该努力联系或修复客户端。
如果是已知合作伙伴，则应提交错误或事件。
在极端情况下，可能需要采用DoS攻击保护，例如阻止调用者。

## 15. 通过 webhooks 推送通知
### 15.1. 范围
服务可以通过Web钩子（Hooks)实现推送通知。
本节介绍以下关键方案：

>通过HTTP回调（通常称为Web Hooks）将通知推送到可公开寻址的服务器。

之所以选择这种方法，是因为它简单、适用范围广，并且对服务订阅者的进入门槛很低。
它旨在作为一组最低要求，并作为其他功能的起点。

### 15.2. 原则
支持Web钩子的服务的核心原则是：
1. 服务必须实现至少一个戳/拉模型。在poke/pull模型中，通知被发送给客户端，然后客户端发送一个请求来获取自上次通知以来的当前状态或更改记录。这种方法避免了消息排序，错过消息和变更集的复杂性。服务可以添加更多的数据来提供丰富的通知。
2. 服务必须实现用于配置回调url的质询/响应协议。
3. 服务应该有建议的过期时间，服务可以根据场景灵活地变化。
4. 服务应该允许那些发出成功通知的订阅永久存在，并且应该容忍合理的停机时间。
5. Firehose 订阅只能通过 HTTPS 提供。服务应要求其他订阅类型为HTTPS。有关详细信息，请参阅“安全性”部分。

### 15.3. 订阅类型
有两种订阅类型，服务可以实现，或者两者都可以。
支持的订阅类型包括：

1. Firehose订阅 - 为订阅应用程序手动创建订阅，通常在应用程序注册门户中。 任何用户同意接收应用的活动通知都会发送到此单个订阅。
2. 每个资源订阅 - 订阅应用程序使用代码以编程方式在运行时为某些特定于用户的实体创建订阅。

支持这两种订阅类型的服务应该为这两种类型提供不同的开发人员体验:

1. Firehose - 服务必须不要求开发人员创建代码，除非直接验证和响应通知。服务必须为订阅管理提供管理UI。服务不应该假设最终用户知道订阅，只知道订阅应用程序的功能。
2. 每个用户 - 服务必须为开发人员提供API，以便在他们的应用程序中创建和管理订阅，以及验证和响应通知。 服务可能希望最终用户了解订阅，并且必须允许最终用户撤销在响应用户操作时直接创建订阅的订阅。

### 15.4. 调用序列
Firehose订阅的调用顺序必须遵循下图。
它显示了应用程序和订阅的手动注册，然后是最终用户使用其中一个服务的API。
在这部分流程中，必须存储两件事：

1. 服务必须存储最终用户同意接收来自此特定应用程序的通知的行为(通常是后台使用OAUTH范围)。
2. 订阅应用程序必须存储最终用户的令牌，以便在收到更改通知后回调详细信息。

序列的最后一部分是通知流本身。

非规范实现指导:服务中的资源发生变化，服务需要运行以下逻辑:

1. 确定有权访问该资源的用户集，因此可能希望应用程序代表他们接收有关该资源的通知。
2. 查看哪些用户已同意接收通知以及从哪些应用收到通知。
3. 查看哪些应用已注册firehose订阅。
4. 加入1,2,3以生成必须发送到应用程序的具体通知集。

应该注意的是，用户同意的行为和建立firehose订阅的行为可以以任何顺序到达。
服务应该发送通知，并以任何顺序处理设置。

![Firehose subscription setup][websequencediagram-firehose-subscription-setup]

对于每用户订阅，应用程序注册是手动或自动的。
每用户订阅的呼叫流程必须遵循下图。
它显示了最终用户使用其中一个服务的API，同样，必须存储相同的两件事：

1.服务必须存储最终用户同意接收来自此特定应用程序的通知的行为（通常是后台使用OAUTH范围）。
2.订阅应用程序必须存储最终用户的令牌，以便在收到更改通知后回拨详细信息。

在这种情况下，使用订阅应用程序中的最终用户令牌以编程方式设置订阅。
应用程序必须与用户令牌一起存储已注册订阅的ID。

非规范性实施指南：在序列的最后部分，当服务中的数据项发生更改且服务需要运行以下逻辑时：

1.找到通过资源与更改的数据对应的订阅集。
2.对于在app +用户令牌下创建的订阅，使用订阅ID和订阅创建者的用户ID向每个订阅的应用发送通知。
 - 对于使用仅限应用程序令牌创建的订阅，请检查已更改数据的所有者或已更改数据可见性的任何用户是否已同意向应用程序发送通知，如果是，则将每个用户ID的一组通知发送给应用程序 每个订阅使用订阅ID。

![User subscription setup][websequencediagram-user-subscription-setup]
  
### 15.5. Verifying subscriptions
当订阅以编程方式更改或通过管理UI门户更改响应时，需要保护订阅服务免受来自可能导致大量通知流量的服务的恶意或意外调用。

对于所有订阅，无论是firehose还是每用户，服务必须在发送任何其他通知之前，通过门户网站UI或API请求作为创建或修改的一部分发送验证请求。

验证请求必须具有以下格式作为订阅的_notificationUrl_的HTTP/HTTPS POST。

```http
POST https://{notificationUrl}?validationToken={randomString}
ClientState: clientOriginatedOpaqueToken (if provided by client on subscription-creation)
Content-Length: 0
```

对于要设置的订阅，应用程序必须以200 OK对此请求进行响应，并将_validationToken_值作为唯一的实体主体。
请注意，如果_notificationUrl_包含查询参数，则_validationToken_参数必须附加“＆”。

如果任何质询请求在发送请求后的5秒内没有收到规定的响应，则服务必须返回错误，不得创建订阅，并且不得向_notificationUrl_发送更多请求或通知。

服务可以对URL所有权执行其他验证。

### 15.6. Receiving notifications
服务应该发送通知以响应服务数据更改，这些更改不包括更改本身的详细信息，但包含足够的信息以供订阅应用程序适当地响应以下过程：

1. 应用程序必须识别用于回调的正确缓存OAuth令牌
2. 应用程序可以查找任何先前的delta令牌以获取相关的更改范围
3. 应用程序必须确定要调用的URL以执行服务的新状态的相关查询，该查询可以是增量查询。

提供将被转发给最终用户的通知的服务可以选择向通知包添加更多细节，以减少其服务上的呼入负载。
此类服务必须清楚，通知不能保证交付，可能有损或无序。

通知可以聚合并分批发送。
应用程序必须准备好在单个推送通知中接收多个事件。

服务必须发送所有Web Hook数据通知作为POST请求。

服务必须允许30秒的通知超时。
如果发生超时或应用程序以5xx响应响应，则服务应该以指数退避重试通知。
所有其他回复都将被忽略。

该服务不得遵循301/302重定向请求。

#### 15.6.1. Notification payload
通知有效负载的基本格式是事件列表，每个事件包含其引用资源已更改的订阅的ID，更改类型，用于标识更改的确切详细信息以及要查看的足够标识信息所应消耗的资源 调用该资源所需的令牌。

对于firehose订阅，这个具体的例子可能如下所示：

```json
{
  "value": [
    {
      "subscriptionId": "32b8cbd6174ab18b",
      "resource": "https://api.contoso.com/v1.0/users/user@contoso.com/files?$delta",
      "userId" : "<User GUID>",
      "tenantId" : "<Tenant Id>"
    }
  ]
}
```

对于每用户订阅，具体示例可能如下所示：

```json
{
  "value": [
    {
      "subscriptionId": "32b8cbd6174ab183",
      "clientState": "clientOriginatedOpaqueToken",
      "expirationDateTime": "2016-02-04T11:23Z",
      "resource": "https://api.contoso.com/v1.0/users/user@contoso.com/files/$delta",
      "userId" : "<User GUID>",
      "tenantId" : "<Tenant Id>"
    },
    {
      "subscriptionId": "97b391179fa22",
      "clientState ": "clientOriginatedOpaqueToken",
      "expirationDateTime": "2016-02-04T11:23Z",
      "resource": "https://api.contoso.com/v1.0/users/user@contoso.com/files/$delta",
      "userId" : "<User GUID>",
      "tenantId" : "<Tenant Id>"
    }
  ]
}
```

以下是JSON有效负载的详细说明。

通知项目包含一个顶级对象，该对象包含一系列事件，每个事件都标识了此通知发送的订阅。

Field | Description
----- | --------------------------------------------------------------------------------------------------
value | Array of events that have been raised within the subscription’s scope since the last notification.

Each item of the events array contains the following properties:

Field              | Description
------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
subscriptionId     | The id of the subscription due to which this notification has been sent.<br/>Services MUST provide the *subscriptionId* field.
clientState        | Services MUST provide the *clientState* field if it was provided at subscription creation time.
expirationDateTime | Services MUST provide the *expirationDateTime* field if the subscription has one.
resource           | Services MUST provide the resource field. This URL MUST be considered opaque by the subscribing application.  In the case of a richer notification it MAY be subsumed by message content that implicitly contains the resource URL to avoid duplication.<br/>If a service is providing this data as part of a more detailed data packet, then it need not be duplicated.
userId             | Services MUST provide this field for user-scoped resources.  In the case of user-scoped resources, the unique identifier for the user should be used.<br/>In the case of resources shared between a specific set of users, multiple notifications must be sent, passing the unique identifier of each user.<br/>For tenant-scoped resources, the user id of the subscription should be used.
tenantId           | Services that wish to support cross-tenant requests SHOULD provide this field. Services that provide notifications on tenant-scoped data MUST send this field.

### 15.7. Managing subscriptions programmatically
对于每用户订阅，必须提供API来创建和管理订阅。
API必须至少支持此处描述的操作。

#### 15.7.1. Creating subscriptions
客户端通过针对订阅资源发出POST请求来创建订阅。
订阅命名空间是通过POST操作进行客户端定义的。

```
https://api.contoso.com/apiVersion/$subscriptions
```

POST请求包含要创建的单个订阅对象。
该订阅对象具有以下属性：

Property Name   | Required | Notes
--------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------
resource        | Yes      | Resource path to watch.
notificationUrl | Yes      | The target web hook URL.
clientState     | No       | Opaque string passed back to the client on all notifications. Callers may choose to use this to provide tagging mechanisms.

如果订阅已成功创建，则服务必须以状态代码201 CREATED和包含至少以下属性的正文进行响应：

Property Name      | Required | Notes
------------------ | -------- | -------------------------------------------------------------------------------------------
id                 | Yes      | Unique ID of the new subscription that can be used later to update/delete the subscription.
expirationDateTime | No       | Uses existing Microsoft REST API Guidelines defined time formats.

订阅的创建应该是幂等的。
限定为auth令牌的属性组合提供唯一性约束。

下面是使用User + Application主体订阅文件通知的示例请求：

```http
POST https://api.contoso.com/files/v1.0/$subscriptions HTTP 1.1
Authorization: Bearer {UserPrincipalBearerToken}

{
  "resource": "http://api.service.com/v1.0/files/file1.txt",
  "notificationUrl": "https://contoso.com/myCallbacks",
  "clientState": "clientOriginatedOpaqueToken"
}
```

服务应该响应这样的消息，其响应格式最低限度如下：

```json
{
  "id": "32b8cbd6174ab18b",
  "expirationDateTime": "2016-02-04T11:23Z"
}
```

下面是一个使用Application-Only主体的示例，其中应用程序正在查看其授权的所有文件：

```http
POST https://api.contoso.com/files/v1.0/$subscriptions HTTP 1.1
Authorization: Bearer {ApplicationPrincipalBearerToken}

{
  "resource": "All.Files",
  "notificationUrl": "https://contoso.com/myCallbacks",
  "clientState": "clientOriginatedOpaqueToken"
}
```

服务应该响应这样的消息，其响应格式最低限度如下：

```json
{
  "id": "8cbd6174abb391179",
  "expirationDateTime": "2016-02-04T11:23Z"
}
```

#### 15.7.2. Updating subscriptions
服务可以支持修改订阅。
  要更新现有订阅的属性，客户端将使用提供ID和需要更改的属性的PATCH请求。
省略的属性将保留其值。
要删除属性，请为其指定值JSON null。

与创建一样，订阅也是单独管理的。

以下请求更改现有订阅的通知URL：

```http
PATCH https://api.contoso.com/files/v1.0/$subscriptions/{id} HTTP 1.1
Authorization: Bearer {UserPrincipalBearerToken}

{
  "notificationUrl": "https://contoso.com/myNewCallback"
}
```

如果PATCH请求包含新的_notificationUrl_，则服务器必须如上所述对其执行验证。
如果新URL无法验证，则服务必须使PATCH请求失败并使订阅保持其先前状态。

该服务必须返回一个空体和“204 No Content”来表示一个成功的补丁。

如果补丁失败，服务必须返回错误正文和状态代码。

操作必须成功或原子化失败。

#### 15.7.3. Deleting subscriptions
服务必须支持删除订阅。
可以通过对订阅资源发出DELETE请求来删除现有订阅：

```http
DELETE https://api.contoso.com/files/v1.0/$subscriptions/{id} HTTP 1.1
Authorization: Bearer {UserPrincipalBearerToken}
```

与更新一样，服务必须返回“204 No Content”以成功删除，或者返回错误正文和状态代码以指示失败。

#### 15.7.4. Enumerating subscriptions
要获取活动订阅列表，客户端使用User + Application或Application-Only bearer token对订阅资源发出GET请求：

```http
GET https://api.contoso.com/files/v1.0/$subscriptions HTTP 1.1
Authorization: Bearer {UserPrincipalBearerToken}
```

服务必须使用User + Application主承载令牌返回如下格式：

```json
{
  "value": [
    {
      "id": "32b8cbd6174ab18b",
      "resource": " http://api.contoso.com/v1.0/files/file1.txt",
      "notificationUrl": "https://contoso.com/myCallbacks",
      "clientState": "clientOriginatedOpaqueToken",
      "expirationDateTime": "2016-02-04T11:23Z"
    }
  ]
}
```

可以使用仅应用程序主承载令牌返回的示例：

```json
{
  "value": [
    {
      "id": "6174ab18bfa22",
      "resource": "All.Files ",
      "notificationUrl": "https://contoso.com/myCallbacks",
      "clientState": "clientOriginatedOpaqueToken",
      "expirationDateTime": "2016-02-04T11:23Z"
    }
  ]
}
```

### 15.8. Security
所有服务URL都必须是HTTPS（即所有入站调用必须是HTTPS）。处理Web Hooks的服务必须接受HTTPS。

我们建议允许客户端定义的Web Hook回调URL的服务不应该通过HTTP传输数据。
这是因为可能会通过客户端，网络，服务器日志和其他机制无意中暴露信息。

但是，由于客户端端点或软件限制，有些情况下无法遵循上述建议。
因此，服务可以允许HTTP钩子URL。

此外，允许客户端定义的HTTP Web挂钩回调URL的服务应该符合工程领导指定的隐私策略。
这通常包括建议客户更喜欢SSL连接并遵守特殊预防措施，以确保正确处理日志和其他服务数据收集。

例如，服务可能不希望开发人员为板载生成证书。
服务可能只在测试帐户上启用此功能。

## 16. Unsupported requests
RESTful API客户端可以请求当前不受支持的功能。
RESTful API必须响应与本节一致的有效但不受支持的请求。

### 16.1. Essential guidance
RESTful API通常会选择限制客户端可以执行的功能。
例如，审计系统允许创建记录但不修改或删除记录。
类似地，一些API将公开集合但需要或以其他方式限制过滤和排序标准，或者可能不支持客户端驱动的分页。

### 16.2. Feature allow list
如果服务不支持以下任何API功能，则必须在呼叫者请求功能时提供错误响应。
功能是：
 - 集合中的密钥寻址，例如：`https://api.contoso.com/v1.0/people/user1@contoso.com`
 - 按属性值过滤集合，例如：`https://api.contoso.com/v1.0/people?$filter=name eq 'david'`
 - 按范围过滤集合，例如：`http://api.contoso.com/v1.0/people?$filter=hireDate ge 2014-01-01和hireDate le 2014-12-31`
 - 通过$ top和$ skip进行客户驱动的分页，例如：`http：//api.contoso.com/v1.0/people？$ top = 5＆$ skip = 2`
 - 按$ orderBy排序，例如：`https://api.contoso.com/v1.0/people?$orderBy=name desc`
 - 提供$ delta令牌，例如：`https://api.contoso.com/v1.0/people?$delta`

#### 16.2.1. Error response
如果调用者请求功能允许列表中找到不受支持的功能，则服务必须提供错误响应。
错误响应必须是来自4xx系列的HTTP状态代码，表示无法满足请求。
除非更具体的错误状态适用于给定的请求，否则服务应该返回“400 Bad Request”和符合Microsoft REST API准则中提供的错误响应指南的错误有效负载。
服务应该在响应消息中包含足够的详细信息，以便开发人员确切地确定不支持请求的哪个部分。

Example:

```http
GET https://api.contoso.com/v1.0/people?$orderBy=name HTTP/1.1
Accept: application/json
```

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json

{
  "error": {
    "code": "ErrorUnsupportedOrderBy",
    "message": "Ordering by name is not supported."
  }
}
```

## 17. Naming guidelines
### 17.1. Approach
命名策略应该有助于开发人员发现功能，而无需经常参考文档。
使用通用模式和标准约定极大地帮助开发人员正确猜测公共属性名称和含义。
服务应该使用详细的命名模式，并且不应该使用缩写词而不是首字母缩略词，这些缩写词是API所代表的域中的主要表达方式（例如Url）。

### 17.2. Casing
 - 首字母缩略词应该遵循套管约定，就像它们是常规词（例如Url）一样。
 - 所有标识符包括名称空间，实体类型，实体集，属性，操作，函数和枚举值应该使用lowerCamelCase。
 - HTTP标头是例外，并且应该使用Capitalized-Hyphenated-Terms的标准HTTP约定。

### 17.3. Names to avoid
某些名称在API域中过载，以至于它们失去了所有含义，或者与使用REST API（例如OAUTH）时无法避免的域中的其他常见用法发生冲突。
服务不应使用以下名称：
 - 背景
 - 范围
 - 资源

### 17.4. Forming compound names
 - 服务应该避免使用诸如'a'，'the'，'of'之类的文章，除非需要传达意义。
 - 例如 不应该使用诸如 a User，theAccount，countOfBooks 之类的名称，而应该首选user，account，bookCount。
 - 服务应该在不这样做时向属性名称添加类型会导致数据如何表示模糊或者导致服务不使用公共属性名称。
 - 在属性名称中添加类型时，服务必须在末尾添加类型，例如createdDateTime。

### 17.5. Identity properties
 - 服务必须为标识属性使用字符串类型。
 - 对于OData服务，服务必须使用OData @id属性来表示资源的规范标识符。
 - 服务可以使用简单的“id”属性来表示资源的本地或遗留主键值。
 - 服务应该使用后缀为“Id”的关系名称来表示另一个资源的外键，例如：subscriptionId。
 - 此属性的内容应该是引用资源的规范ID。

### 17.6. Date and time properties
 - 对于同时需要日期和时间的属性，服务必须使用后缀“DateTime”。
 - 对于只需要日期信息而不指定时间的属性，服务必须使用后缀“date”，例如birthDate。
 - 对于只需要时间信息而没有指定日期的属性，服务必须使用后缀“time”，例如appointment mentstarttime。

### 17.7. Name properties
 - 对于通常显示给用户的资源的整体名称，服务必须使用属性名称“displayName”。
 - 服务可能使用其他通用命名属性，例如givenName、姓氏、signInName。

### 17.8. Collections and counts
 - 服务必须使用正确的英语将集合命名为复数名词或复数名词短语。
 - 服务可使用简化英语的名词，有复数，不常见的口头使用。
 - 例如，可以使用模式而不是模式。
 - 服务必须用一个或多个后缀为“Count”的名词短语来命名资源计数。

### 17.9. Common property names
如果服务有属性，其数据与下面的名称匹配，则服务必须使用该表中的名称。
随着服务添加更常用的术语，该表将会增长。
添加此类术语的服务所有者应该建议在本文档中添加这些术语。

| |
|------------- |
 attendees     |
 body          |  
 createdDateTime |
 childCount    |  
 children      |  
 contentUrl    |  
 country       |  
 createdBy     |  
 displayName   |
 errorUrl      |
 eTag          |
 event         |
 expirationDateTime |
 givenName     |
 jobTitle      |
 kind          |  
 id            |
 lastModifiedDateTime |
 location      |
 memberOf      |
 message       |
 name          |  
 owner         |
 people        |  
 person        |  
 postalCode    |
 photo         |
 preferredLanguage |
 properties    |
 signInName    |
 surname       |
 tags          |
 userPrincipalName |
 webUrl        |
 
 ## 18. Appendix
### 18.1. Sequence diagram notes
本文档中的所有序列图均使用WebSequenceDiagrams.com网站生成。 要生成它们，请将以下文本粘贴到Web工具中。

#### 18.1.1. Push notifications, per user flow
```
=== Begin Text ===
note over Developer, Automation, App Server:
     An App Developer like MovieMaker
     Wants to integrate with primary service like Dropbox
end note
note over DB Portal, DB App Registration, DB Notifications, DB Auth, DB Service: The primary service like Dropbox
note over Client: The end users' browser or installed app

note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Manual App Registration


Developer <--> DB Portal : Login into Portal, App Registration UX
DB Portal -> +DB App Registration: App Name etc.
note over DB App Registration: Confirm Portal Access Token

DB App Registration -> -DB Portal: App ID
DB Portal <--> App Server: Developer copies App ID

note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Manual Notification Registration

Developer <--> DB Portal: webhook registration UX
DB Portal -> +DB Notifications: Register: App Server webhook URL, Scope, App ID
Note over DB Notifications : Confirm Portal Access Token
DB Notifications -> -DB Portal: notification ID
DB Portal --> App Server : Developer may copy notification ID


note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Client Authorization

Client -> +App Server : Request access to DB protected information
App Server -> -Client : Redirect to DB Authorization endpoint with authorization request
Client -> +DB Auth : Redirected authorization request
Client <--> DB Auth : Authorization UX
DB Auth -> -Client : Redirect back to App Server with code
Client -> +App Server : Redirect request back to access server with access code
App Server -> +DB Auth : Request tokens with access code
note right of DB Service: Cache that this User ID provided access to App ID
DB Auth -> -App Server : Response with access, refresh, and ID tokens
note right of App Server : Cache tokens by user ID
App Server -> -Client : Return information to client

note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Notification Flow

Client <--> DB Service: Changes to user data - typical via interacting with App Server via Client
DB Service -> App Server : Notification with notification ID and user ID
App Server -> +DB Service : Request changed information with cached access tokens and "since" token
note over DB Service: Confirm User Access Token
DB Service -> -App Server : Response with data and new "since" token
note right of App Server: Update status and cache new "since" token
=== End Text ===
```

#### 18.1.2. Push notifications, firehose flow

#### 18.1.2. Push notifications, firehose flow

```
=== Begin Text ===
note over Developer, Automation, App Server:
     An App Developer like MovieMaker
     Wants to integrate with primary service like Dropbox
end note
note over DB Portal, DB App Registration, DB Notifications, DB Auth, DB Service: The primary service like Dropbox
note over Client: The end users' browser or installed app

note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : App Registration

alt Automated app registration
   Developer <--> Automation: Configure
   Automation -> +DB App Registration: App Name etc.
   note over DB App Registration: Confirm App Access Token
   DB App Registration -> -Automation: App ID, App Secret
   Automation --> App Server : Embed App ID, App Secret
else Manual app registration
   Developer <--> DB Portal : Login into Portal, App Registration UX
   DB Portal -> +DB App Registration: App Name etc.
   note over DB App Registration: Confirm Portal Access Token

   DB App Registration -> -DB Portal: App ID
   DB Portal <--> App Server: Developer copies App ID
end

note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Client Authorization

Client -> +App Server : Request access to DB protected information
App Server -> -Client : Redirect to DB Authorization endpoint with authorization request
Client -> +DB Auth : Redirected authorization request
Client <--> DB Auth : Authorization UX
DB Auth -> -Client : Redirect back to App Server with code
Client -> +App Server : Redirect request back to access server with access code
App Server -> +DB Auth : Request tokens with access code
note right of DB Service: Cache that this User ID provided access to App ID
DB Auth -> -App Server : Response with access, refresh, and ID tokens
note right of App Server : Cache tokens by user ID
App Server -> -Client : Return information to client



note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Notification Registration

App Server->+DB Notifications: Register: App server webhook URL, Scope, App ID
note over DB Notifications : Confirm User Access Token
DB Notifications -> -App Server: notification ID
note right of App Server : Cache the Notification ID and User Access Token



note over Developer, Automation, App Server, DB Portal, DB App Registration, DB Notifications, Client : Notification Flow

Client <--> DB Service: Changes to user data - typical via interacting with App Server via Client
DB Service -> App Server : Notification with notification ID and user ID
App Server -> +DB Service : Request changed information with cached access tokens and "since" token
note over DB Service: Confirm User Access Token
DB Service -> -App Server : Response with data and new "since" token
note right of App Server: Update status and cache new "since" token



=== End Text ===
```

[fielding]: https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm
[IANA-headers]: http://www.iana.org/assignments/message-headers/message-headers.xhtml
[rfc7231-7-1-1-1]: https://tools.ietf.org/html/rfc7231#section-7.1.1.1
[rfc-7230-3-1-1]: https://tools.ietf.org/html/rfc7230#section-3.1.1
[rfc-7231]: https://tools.ietf.org/html/rfc7231
[rest-in-practice]: http://www.amazon.com/REST-Practice-Hypermedia-Systems-Architecture/dp/0596805829/
[rest-on-wikipedia]: http://en.wikipedia.org/wiki/Representational_state_transfer
[rfc-5789]: http://tools.ietf.org/html/rfc5789
[rfc-5988]: http://tools.ietf.org/html/rfc5988
[rfc-3339]: https://tools.ietf.org/html/rfc3339
[rfc-5322-3-3]: https://tools.ietf.org/html/rfc5322#section-3.3
[cors-preflight]: http://www.w3.org/TR/cors/#resource-preflight-requests
[rfc-3864]: http://www.ietf.org/rfc/rfc3864.txt
[odata-json-annotations]: http://docs.oasis-open.org/odata/odata-json-format/v4.0/os/odata-json-format-v4.0-os.html#_Instance_Annotations
[cors]: http://www.w3.org/TR/access-control/
[cors-user-credentials]: http://www.w3.org/TR/access-control/#user-credentials
[cors-simple-headers]: http://www.w3.org/TR/access-control/#simple-header
[rfc-4627]: https://tools.ietf.org/html/rfc4627
[iso-8601]: http://www.ecma-international.org/ecma-262/5.1/#sec-15.9.1.15
[clr-time]: https://msdn.microsoft.com/en-us/library/System.DateTime(v=vs.110).aspx
[ecmascript-time]: http://www.ecma-international.org/ecma-262/5.1/#sec-15.9.1.1
[ole-date]: https://docs.microsoft.com/en-us/windows/desktop/api/oleauto/nf-oleauto-varianttimetosystemtime
[ticks-time]: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724290(v=vs.85).aspx
[unix-time]: https://msdn.microsoft.com/en-us/library/1f4c8f33.aspx
[windows-time]: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724290(v=vs.85).aspx
[excel-time]: http://support.microsoft.com/kb/214326?wa=wsignin1.0
[wikipedia-iso8601-durations]: http://en.wikipedia.org/wiki/ISO_8601#Durations
[wikipedia-iso8601-intervals]: http://en.wikipedia.org/wiki/ISO_8601#Time_intervals
[wikipedia-iso8601-repeatingintervals]: http://en.wikipedia.org/wiki/ISO_8601#Repeating_intervals
[principle-of-least-astonishment]: http://en.wikipedia.org/wiki/Principle_of_least_astonishment
[odata-breaking-changes]: http://docs.oasis-open.org/odata/odata/v4.0/errata02/os/complete/part1-protocol/odata-v4.0-errata02-os-part1-protocol-complete.html#_Toc406398209
[websequencediagram-firehose-subscription-setup]: http://www.websequencediagrams.com/cgi-bin/cdraw?lz=bm90ZSBvdmVyIERldmVsb3BlciwgQXV0b21hdGlvbiwgQXBwIFNlcnZlcjogCiAgICAgQW4AEAUAJwkgbGlrZSBNb3ZpZU1ha2VyACAGV2FudHMgdG8gaW50ZWdyYXRlIHdpdGggcHJpbWFyeSBzZXJ2aWNlADcGRHJvcGJveAplbmQgbm90ZQoAgQwLQiBQb3J0YWwsIERCAIEJBVJlZ2lzdHIAgRkHREIgTm90aWZpYwCBLAVzACEGdXRoACsFUwBgBjogVGhlAF0eAIF_CkNsaWVudAAtBmVuZCB1c2VycycgYnJvd3NlciBvciBpbnN0YWxsZWQgYXBwCgCBIQwAgiQgAIFABQCBIS8AgQoGIDogTWFudWFsAIFzEQoKCgCDAgo8LS0-AIIqCiA6IExvZ2luIGludG8Agj8JAII1ECBVWCAKACoKLT4gKwCCWBM6AIQGBU5hbWUgZXRjLgCDFQ4AGxJDb25maXJtAIEBCEFjY2VzcyBUb2tlbgoKAIM3EyAtPiAtAINkCQBnBklEAIEMCwCBVQUAhQIMAIR3CmNvcGllcwArCACCIHAAhHMMAIMKDwCDABg6IHdlYmhvb2sgcgCCeg4AgnUSAIVQDToAhXYHZXIAgwgGAIcTBgBECVVSTCwgU2NvcGUAhzIGSUQKTgCGPQwAhhwNIACDBh4AHhEAgxEPbgCBagwAgxwNAIMaDiAAgx0MbWF5IGNvcHkALREAhVtqAIZHB0F1dGhvcml6AIY7BwCGXQctPiArAIEuDVJlcXVlc3QgYQCFOQZ0byBEQiBwcm90ZWN0ZWQgaW5mb3IAiiQGCgCDBQstPiAtAIctCVJlZGlyZWN0ADYHAGwNIGVuZHBvaW50AIoWBmEADw1yAHYGAIEQDACJVAcASwtlZAAYHgCICAgAMAcAcA4AhGoGAE0FAIEdFmJhY2sgdG8AhF8NaXRoIGNvZGUAghoaaQCBagcAgToHAD0JAII-B3MAPgsAglEHAEsFAIIzDgCBXw0Agn8GdG9rZW5zACcSAI0_BXJpZ2h0IG9mAItpDUNhY2hlIHRoYXQgdGhpcyBVc2VyIElEIHByb3ZpZGVkAINNCwCIZgoAggcJAIN7D3Nwb25zAI0_BwCECgYsIHJlZnJlc2gsIGFuZCBJRACBHAcAgQMPAIYADQCBDAcAgUUGYnkAjFkFIElEAIQkG3R1cm4AhF4MIHRvIGMAjR8FAIwRagCJVw1GbG93AIYqCQCMaQgAgmoKaGFuZ2UAj3YFAIFXBWRhdGEgLSB0eXBpY2FsIHZpYQCQDgVyYWN0aW5nAJAPBgCJQQt2aWEAjnsHCgCPNgogAIhDEACKZw0AkFMFAIkBDwCDDAUAgkYWKwBNCwCHWApjAIEyBQCHRg0AhWUHYWNoAIQeDACEfwVhbmQgInNpbmNlIgCFEQYAkSQOAIR3CgCNfwcAhHQFAIpQEACBUgsAhFAcAII8BWFuZCBuZXcAYRQAhFUTOiBVcGRhdGUgc3RhdHUAgSkGAIFDBQAxEwoKCg&s=mscgen
[websequencediagram-user-subscription-setup]: http://www.websequencediagrams.com/cgi-bin/cdraw?lz=bm90ZSBvdmVyIERldmVsb3BlciwgQXV0b21hdGlvbiwgQXBwIFNlcnZlcjogCiAgICAgQW4AEAUAJwkgbGlrZSBNb3ZpZU1ha2VyACAGV2FudHMgdG8gaW50ZWdyYXRlIHdpdGggcHJpbWFyeSBzZXJ2aWNlADcGRHJvcGJveAplbmQgbm90ZQoAgQwLQiBQb3J0YWwsIERCAIEJBVJlZ2lzdHIAgRkHREIgTm90aWZpYwCBLAVzACEGdXRoACsFUwBgBjogVGhlAF0eAIF_CkNsaWVudAAtBmVuZCB1c2VycycgYnJvd3NlciBvciBpbnN0YWxsZWQgYXBwCgCBIQwAgiQgAIFABQCBIS8AgQoGIDoAgWwRCgphbHQAgyUIAIEHBiByABQMICAAgxsLPC0tPgCDTws6IENvbmZpZ3VyZQogIACDaAsgLT4gKwCCWBMAegZOYW1lIGV0Yy4AhAgFAIMaDQAfEgBdBXJtAIQ_BUFjY2VzcyBUb2tlAIETBgCDOxIgLT4gLQCBFgxBcHAgSUQAhHwIY3JldACBGxAtPgCFFgsgOiBFbWJlZAAkFGVsc2UgTWFudWFsAIIEJACEbQkgOiBMb2dpbiBpbnRvAIUBCQCBKRFVWACGGAUALQoAgh8mAIIZKwCBCAcAgjoNAIIsHACGLwkAgj8IAIESDgCECAYAh1ELAIdFCmNvcGllcwAuCGVuZACEeGoAhWQHQXV0aG9yaXoAhV8HAIV6By0-ICsAg2ANUmVxdWVzdCBhAIRVBnRvIERCIHByb3RlY3RlZCBpbmZvcgCJQQYKAIQaCy0-IC0AhkoJUmVkaXJlY3QANgcAbA0gZW5kcG9pbnQAiTMGYQAPDXIAdgYAgRAMAIhxBwBLC2VkABgeAIRjCAAwB0EAcQxVWAoASQgAgRwWYmFjayB0bwCFdAwAilwFY29kZQCCGRppAIFpBwCBOQcAPQkAgj0HcwA-CwCCUAcASwUAgjIOAIFeDQCCfgZ0b2tlbnMAJxIAjFsFcmlnaHQgb2YAiwUNQ2FjaGUgdGhhdCB0aGlzIFVzZXIgSUQgcHJvdmlkZWQAg0wLAIU6BwCCBAwAg3oPc3BvbnMAjFsHAIQJBiwgcmVmcmVzaCwgYW5kIElEAIEcBwCBAw8AiDENAIEMBwCBRQZieQCLdQUgSUQAhCMbdHVybgCEXQwgdG8gYwCMOwUKCgCLL2oAjXUMAIwTDwCPNQotPisAjhwQOgCORQdlcgCMVwYAg3YIZWJob29rIFVSTCwgU2NvcGUAkAEGSUQAjwoOAI5rDSAAi2UKAINFBQCLYw0AHBEAgzUOOiBuAIE2DABgCACDCB1oZQCBaQ5JRACDYwUAahIAghB4RmxvdwCJMwkAjE0IAIV0CmhhbmdlAJIcBQCEYQVkYXRhIC0gdHlwaWNhbCB2aWEAkjQFcmFjdGluZwCSNQYAjV8LdmlhAJEhBwoAkVwKIACNfhAAhAsNAJJ5BQCCWQ8AhhYFAIVQFisATQsAimEKYwCBMgUAik8NAIhvB2FjaACHKAwAiAkFYW5kICJzaW5jZSIAiBsGAJNKDgCIAQoAhB0cAIFSCwCHWhwAgjwFYW5kIG5ldwBhFACHXxM6IFVwZGF0ZSBzdGF0dQCBKQYAgUMFADETCgoK&s=mscgen






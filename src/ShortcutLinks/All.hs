{-# LANGUAGE
OverloadedStrings
  #-}


module ShortcutLinks.All
(
  Shortcut,
  allShortcuts,

  -- * Encyclopedias
  wikipedia, tvtropes,

  -- * Social networks
  facebook, vk,

  -- * Major search engines
  google, duckduckgo, yandex, baidu,

  -- * Programming language libraries
  npm, jam, rubygems, pypi, metacpanPod, metacpanRelease, hackage, cargo,
  pub, hex, cran, swiprolog, dub, bpkg, pear,

  -- * Code hosting
  github, gitlab, bitbucket,

  -- * OS packages
  -- ** Mobile
  googleplay,
  -- ** Windows
  chocolatey,
  -- ** OS X
  braumeister,
  -- ** Linux
  debian, aur, mint, fedora, gentoo, opensuse, mageia,

  -- * Addons
  -- ** Text editors
  marmalade, melpa, elpa, packagecontrol, atom, jedit,
  -- ** Browsers
  opera, firefox, chrome,

  -- * Manuals
  ghcExt,

  -- * Standards
  rfc,
)
where


-- General
import Data.Monoid
import Control.Applicative
import Control.Monad
import Data.Maybe
-- Text
import qualified Data.Text as T
import Data.Text (Text)
import Data.Char
-- shortcut-links
import ShortcutLinks.Utils


type Shortcut = Maybe Text -> Text -> Either String Text

-- | A list of all functions included in this module.
allShortcuts :: [Shortcut]
allShortcuts = [
  -- encyclopedias
  wikipedia, tvtropes,
  -- social networks
  facebook, vk,
  -- search engines
  google, duckduckgo, yandex, baidu,
  -- programming language libraries
  npm, jam, rubygems, pypi, metacpanPod, metacpanRelease, hackage, cargo,
  pub, hex, cran, swiprolog, dub, bpkg, pear,
  -- code hosting
  github, gitlab, bitbucket,
  -- OS
  googleplay, chocolatey, braumeister,
  -- OS – Linux
  debian, aur, mint, fedora, gentoo, opensuse, mageia,
  -- text editors
  marmalade, melpa, elpa, packagecontrol, atom, jedit,
  -- browsers
  opera, firefox, chrome,
  -- manuals
  ghcExt,
  -- standards
  rfc ]

-- | <https://facebook.com Facebook>
--
-- Link example:
-- @[green]@ →
-- <https://facebook.com/green>
facebook :: Shortcut
facebook _ q = Right $ "https://facebook.com/" <> q

-- | <https://vk.com Vkontakte> (Вконтакте)
--
-- Link example #1:
-- @[green]@ →
-- <https://vk.com/green>
--
-- Link example #2:
--
-- @[1337]@ →
-- <https://vk.com/id1337>
vk :: Shortcut
vk _ q = Right $ "https://vk.com/" <> q'
  where q' = if not (T.null q) && isDigit (T.head q) then "id" <> q else q

-- | <https://google.com Google>
--
-- Link example:
-- @[random query]@ →
-- <https://www.google.com/search?nfpr=1&q=random+query random query>
google :: Shortcut
google _ q = Right $
  "https://google.com/search?nfpr=1&q=" <> replaceSpaces '+' q

-- | <https://duckduckgo.com Duckduckgo>
--
-- Link example:
-- @[random query]@ →
-- <https://duckduckgo.com/?q=random+query random query>
duckduckgo :: Shortcut
duckduckgo _ q = Right $ "https://duckduckgo.com/?q=" <> replaceSpaces '+' q

-- | <http://yandex.ru Yandex> (Russian search engine)
--
-- Link example:
-- @[random query]@ →
-- <http://yandex.ru/search/?noreask=1&text=random+query random query>
yandex :: Shortcut
yandex _ q = Right $
  "http://yandex.ru/search/?noreask=1&text=" <> replaceSpaces '+' q

-- | <http://baidu.com Baidu> (Chinese search engine)
--
-- Link example:
-- @[random query]@ →
-- <http://baidu.com/s?nojc=1&wd=random+query random query>
baidu :: Shortcut
baidu _ q = Right $ "http://baidu.com/s?nojc=1&wd=" <> replaceSpaces '+' q

-- | __Node.js__ – <https://npmjs.com NPM>
--
-- Link example:
-- @[markdown]@ →
-- <https://www.npmjs.com/package/markdown markdown>
npm :: Shortcut
npm _ q = Right $ "https://npmjs.com/package/" <> q

-- | __Javascript__ – <http://jamjs.org/packages/#/ Jam>
--
-- Link example:
-- @[pagedown]@ →
-- <http://jamjs.org/packages/#/details/pagedown pagedown>
jam :: Shortcut
jam _ q = Right $ "http://jamjs.org/packages/#/details/" <> q

-- | __Ruby__ – <https://rubygems.org RubyGems.org>
--
-- Link example:
-- @[github-markdown]@ →
-- <https://rubygems.org/gems/github-markdown github-markdown>
rubygems :: Shortcut
rubygems _ q = Right $ "https://rubygems.org/gems/" <> q

-- | __Python__ – <https://pypi.python.org/pypi PyPI>
--
-- Link example:
-- @[Markdown]@ →
-- <https://pypi.python.org/pypi/Markdown Markdown>
pypi :: Shortcut
pypi _ q = Right $ "https://pypi.python.org/pypi/" <> q

-- | __Perl__ – <https://metacpan.org MetaCPAN> (by module)
--
-- Link example:
-- @[Text::Markdown]@ →
-- <https://metacpan.org/pod/Text::Markdown Text::Markdown>
metacpanPod :: Shortcut
metacpanPod _ q = Right $ "https://metacpan.org/pod/" <> q

-- | __Perl__ – <https://metacpan.org MetaCPAN> (by release)
--
-- Link example:
-- @[Text-Markdown]@ →
-- <https://metacpan.org/release/Text-Markdown Text-Markdown>
metacpanRelease :: Shortcut
metacpanRelease _ q = Right $ "https://metacpan.org/release/" <> q

-- | __Haskell__ – <https://hackage.haskell.org Hackage>
--
-- Link example:
-- @[cmark]@ →
-- <https://hackage.haskell.org/package/cmark cmark>
hackage :: Shortcut
hackage _ q = Right $ "https://hackage.haskell.org/package/" <> q

-- | __Rust__ – <https://crates.io Cargo>
--
-- Link example:
-- @[hoedown]@ →
-- <https://crates.io/crates/hoedown hoedown>
cargo :: Shortcut
cargo _ q = Right $ "https://crates.io/crates/" <> q

-- | __PHP__ – <http://pear.php.net PEAR>
--
-- Link example:
-- @[Text_Wiki_Doku]@ →
-- <http://pear.php.net/package/Text_Wiki_Doku Text_Wiki_Doku>
pear :: Shortcut
pear _ q = Right $ "http://pear.php.net/package/" <> q

-- | __Dart__ – <https://pub.dartlang.org pub>
--
-- Link example:
-- @[md_proc]@ →
-- <https://pub.dartlang.org/packages/md_proc md_proc>
pub :: Shortcut
pub _ q = Right $ "https://pub.dartlang.org/packages/" <> q

-- | __R__ – <http://cran.r-project.org/web/packages/ CRAN>
--
-- Link example:
-- @[markdown]@ →
-- <http://cran.r-project.org/web/packages/markdown markdown>
cran :: Shortcut
cran _ q = Right $ "http://cran.r-project.org/web/packages/" <> q

-- | __Erlang__ – <https://hex.pm Hex>
--
-- Link example:
-- @[earmark]@ →
-- <https://hex.pm/packages/earmark earmark>
hex :: Shortcut
hex _ q = Right $ "https://hex.pm/packages/" <> q

-- | __SWI-Prolog__ – <http://www.swi-prolog.org/pack/list packages>
--
-- Link example:
-- @[markdown]@ →
-- <http://www.swi-prolog.org/pack/list?p=markdown markdown>
swiprolog :: Shortcut
swiprolog _ q = Right $ "http://www.swi-prolog.org/pack/list?p=" <> q

-- | __D__ – <http://code.dlang.org DUB>
--
-- Link example:
-- @[dmarkdown]@ →
-- <http://code.dlang.org/packages/dmarkdown dmarkdown>
dub :: Shortcut
dub _ q = Right $ "http://code.dlang.org/packages/" <> q

-- | __Bash__ – <http://bpkg.io bpkg>
--
-- Link example:
-- @[markdown]@ →
-- <http://www.bpkg.io/pkg/markdown markdown>
bpkg :: Shortcut
bpkg _ q = Right $ "http://bpkg.io/pkg/" <> q

-- | Github
--
-- Link example:
-- @[aelve/shortcut-links](\@gh)@ →
-- <https://github.com/aelve/shortcut-links aelve/shortcut-links>
--
-- The repository owner can also be given as an option:
--
-- @[shortcut-links](\@gh(aelve))@ →
-- <https://github.com/aelve/shortcut-links shortcut-links>
github :: Shortcut
github mbOwner q = case mbOwner of
  Nothing    -> Right $ "https://github.com/" <> q
  Just owner -> Right $ "https://github.com/" <> owner <> "/" <> q

-- | Bitbucket
--
-- Link example:
-- @[bos/text](\@bitbucket)@ →
-- <https://bitbucket.org/bos/text bos/text>
--
-- The repository owner can also be given as an option:
--
-- @[text](\@bitbucket(bos))@ →
-- <https://bitbucket.org/bos/text text>
bitbucket :: Shortcut
bitbucket mbOwner q = case mbOwner of
  Nothing    -> Right $ "https://bitbucket.org/" <> q
  Just owner -> Right $ "https://bitbucket.org/" <> owner <> "/" <> q

-- | Gitlab
--
-- Link example:
-- @[learnyou/lysa](\@gitlab)@ →
-- <https://gitlab.com/learnyou/lysa learnyou/lysa>
--
-- The repository owner can also be given as an option:
--
-- @[lysa](\@gitlab(learnyou))@ →
-- <https://gitlab.com/learnyou/lysa lysa>
--
-- Note that links like <https://gitlab.com/owner> work but are going to be
-- automatically redirected to either <https://gitlab.com/u/owner> or
-- <https://gitlab.com/groups/owner>, depending on whether it's a user or a
-- team. So, it's a case when the “links have to look as authentic as
-- possible” principle is violated (but c'mon, this “u” thing looks ugly
-- anyway).
gitlab :: Shortcut
gitlab mbOwner q = case mbOwner of
  Nothing    -> Right $ "https://gitlab.com/" <> q
  Just owner -> Right $ "https://gitlab.com/" <> owner <> "/" <> q

-- | __Android__ – <https://play.google.com Google Play> (formerly Play Market)
--
-- Link example:
-- @[com.opera.mini.native]@ →
-- <https://play.google.com/store/apps/details?id=com.opera.mini.native Opera Mini>
googleplay :: Shortcut
googleplay _ q = Right $ "https://play.google.com/store/apps/details?id=" <> q

-- | <http://braumeister.org Braumeister> (Homebrew formulas)
--
-- Link example:
-- @[multimarkdown]@ →
-- <http://braumeister.org/formula/multimarkdown multimarkdown>
braumeister :: Shortcut
braumeister _ q = Right $ "http://braumeister.org/formula/" <> q

-- | <https://chocolatey.org Chocolatey>
--
-- Link example:
-- @[Opera]@ →
-- <https://chocolatey.org/packages/Opera Opera>
chocolatey :: Shortcut
chocolatey _ q = Right $ "https://chocolatey.org/packages/" <> q

-- | __Debian__ – <https://debian.org/distrib/packages packages (stable)>
debian :: Shortcut
debian _ q = Right $ "https://packages.debian.org/stable/" <> q

-- | __Arch Linux__ – <https://aur.archlinux.org AUR> (“user repository”)
aur :: Shortcut
aur _ q = Right $ "https://aur.archlinux.org/packages/" <> q

-- | __Gentoo__ – <https://packages.gentoo.org packages>
gentoo :: Shortcut
gentoo _ q = Right $ "https://packages.gentoo.org/package/" <> q

-- | __openSUSE__ – <http://software.opensuse.org packages>
opensuse :: Shortcut
opensuse _ q = Right $ "http://software.opensuse.org/package/" <> q

-- | __Linux Mint__ – <http://community.linuxmint.com/software/browse packages>
mint :: Shortcut
mint _ q = Right $ "http://community.linuxmint.com/software/view/" <> q

-- | __Mageia__ – <http://mageia.madb.org packages>
mageia :: Shortcut
mageia _ q = Right $ "http://mageia.madb.org/package/show/name/" <> q

-- | __Fedora__ – <https://admin.fedoraproject.org/pkgdb packages>
fedora :: Shortcut
fedora _ q = Right $ "https://admin.fedoraproject.org/pkgdb/package/" <> q

-- | __Emacs__ – <https://marmalade-repo.org Marmalade>
marmalade :: Shortcut
marmalade _ q = Right $ "https://marmalade-repo.org/packages/" <> q

-- | __Emacs__ – <http://melpa.org MELPA>
melpa :: Shortcut
melpa _ q = Right $ "http://melpa.org/#/" <> q

-- | __Emacs__ – <https://elpa.gnu.org ELPA>
elpa :: Shortcut
elpa _ q = Right $ "https://elpa.gnu.org/packages/" <> q

-- | __Sublime Text__ – <https://packagecontrol.io Package Control>
packagecontrol :: Shortcut
packagecontrol _ q = Right $ "https://packagecontrol.io/packages/" <> q

-- | __Atom__ – <https://atom.io/packages packages>
--
-- Link example:
-- @[tidy-markdown]@ →
-- <https://atom.io/packages/tidy-markdown tidy-markdown>
atom :: Shortcut
atom _ q = Right $ "https://atom.io/packages/" <> q

-- | __jEdit__ – <http://plugins.jedit.org packages>
--
-- Link example:
-- @[MarkdownPlugin]@ →
-- <http://plugins.jedit.org/plugins/?MarkdownPlugin MarkdownPlugin>
jedit :: Shortcut
jedit _ q = Right $ "http://plugins.jedit.org/plugins/?" <> q

-- | __Opera__ – <https://addons.opera.com extensions>
--
-- Link example:
-- @[amazon-for-opera]@ →
-- <https://addons.opera.com/extensions/details/amazon-for-opera Amazon for Opera>
opera :: Shortcut
opera _ q = Right $ "https://addons.opera.com/extensions/details/" <> q

-- | __Firefox__ – <https://addons.mozilla.org/firefox Add-ons> (extensions, themes)
--
-- Link example:
-- @[tree-style-tab]@ →
-- <https://addons.mozilla.org/firefox/addon/tree-style-tab Tree Style Tab>
firefox :: Shortcut
firefox _ q = Right $ "https://addons.mozilla.org/firefox/addon/" <> q

-- | __Chrome__ – <https://chrome.google.com/webstore Chrome Web Store> (extensions, apps, themes)
--
-- Link example:
-- @[hdokiejnpimakedhajhdlcegeplioahd]@ →
-- <https://chrome.google.com/webstore/detail/hdokiejnpimakedhajhdlcegeplioahd LastPass>
chrome :: Shortcut
chrome _ q = Right $ "https://chrome.google.com/webstore/detail/" <> q

-- | GHC extensions
--
-- Link example:
-- @[ViewPatterns]@ →
-- <https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/syntax-extns.html#view-patterns ViewPatterns>
ghcExt :: Shortcut
ghcExt _ e = case lookup e ghcExtsList of
  Nothing -> Left (T.unpack ("unknown GHC extension '" <> e <> "'"))
  Just l  -> Right l

-- | RFCs
--
-- Link example:
-- @[RFC 2026]@ →
-- <https://tools.ietf.org/html/rfc2026 RFC 2026>
--
-- Precise format of recognised text: optional “rfc” (case-insensitive), then
-- arbitrary amount of spaces and punctuation, then the number. Examples:
-- “RFC 2026”, “RFC-2026”, “rfc2026”, “rfc #2026”, “2026”, “#2026”.
rfc :: Shortcut
rfc _ x = do
  let n = T.dropWhile (not . isAlphaNum) $
            if T.toLower (T.take 3 x) == "rfc" then T.drop 3 x else x
  unless (T.all isDigit n) $
    Left "non-digits in RFC number"
  when (T.null n) $
    Left "no RFC number"
  let n' = T.dropWhile (== '0') n
  when (T.null n') $
    Left "RFC number can't be 0"
  return ("https://tools.ietf.org/html/rfc" <> n')

-- | Wikipedia
--
-- Link example:
-- @[grey-headed flying fox]@ →
-- <https://en.wikipedia.org/wiki/Grey-headed_flying_fox>
--
-- Optionally takes a language code (“ru”, “de”, “it”, etc) – without it,
-- English Wikipedia is assumed.
wikipedia :: Shortcut
wikipedia mbLang q = Right $
  mconcat ["https://", lang, ".wikipedia.org/wiki/", q']
  where
    lang = fromMaybe "en" mbLang
    q'   = titleFirst (replaceSpaces '_' q)

-- | TV Tropes
--
-- Link example #1:
-- @[so bad, it's good](\@tvtropes)@ →
-- <http://tvtropes.org/pmwiki/pmwiki.php/Main/SoBadItsGood>
--
-- Link example #2:
-- @[Elementary](\@tvtropes(series))@ →
-- <http://tvtropes.org/pmwiki/pmwiki.php/Series/Elementary>
tvtropes :: Shortcut
tvtropes mbCategory q = Right $
  mconcat ["http://tvtropes.org/pmwiki/pmwiki.php/", category, "/", q']
  where
    category = maybe "Main" titleFirst mbCategory
    isSep c = (isSpace c || isPunctuation c) && c /= '\''
    -- Break into words, transform each word like “it's” → “Its”, and concat.
    -- Note that e.g. “man-made” is considered 2 separate words.
    q' = T.concat $ map (titleFirst . T.filter isAlphaNum) (T.split isSep q)

ghcExtsList :: [(Text, Text)]
ghcExtsList = do
  let (.=) = (,)
      base = "https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/"
      prefix x = map (\(a, b) -> (a, x <> b))
  prefix base $ concat [
    prefix "syntax-extns.html" [
      "DisambiguateRecordFields" .= "#disambiguate-fields",
      "EmptyCase" .= "#empty-case",
      "NoImplicitPrelude" .= "#rebindable-syntax",
      "NegativeLiterals" .= "#negative-literals",
      "RebindableSyntax" .= "#rebindable-syntax",
      "PatternGuards" .= "#pattern-guards",
      "ViewPatterns" .= "#view-patterns",
      "UnicodeSyntax" .= "#unicode-syntax",
      "MagicHash" .= "#magic-hash",
      "ParallelListComp" .= "#parallel-list-comprehensions",
      "TransformListComp" .= "#generalised-list-comprehensions",
      "MonadComprehensions" .= "#monad-comprehensions",
      "ExplicitNamespaces" .= "#explicit-namespaces",
      "RecursiveDo" .= "#recursive-do-notation",
      "RecordWildCards" .= "#record-wildcards",
      "NamedFieldPuns" .= "#record-puns",
      "PackageImports" .= "#package-imports",
      "LambdaCase" .= "#lambda-case",
      "MultiWayIf" .= "#multi-way-if",
      "NumDecimals" .= "#num-decimals",
      "BinaryLiterals" .= "#binary-literals",
      "PostfixOperators" .= "#postfix-operators",
      "TupleSections" .= "#tuple-sections",
      "PatternSynonyms" .= "#pattern-synonyms" ],

    prefix "data-type-extensions.html" [
      "GADTs" .= "#gadt",
      "GADTSyntax" .= "#gadt-style",
      "ExistentialQuantification" .= "#existential-quantification",
      "LiberalTypeSynonyms" .= "#type-synonyms",
      "EmptyDataDecls" .= "#nullary-types",
      "DatatypeContexts" .= "#datatype-contexts",
      "TypeOperators" .= "#type-operators" ],

    prefix "other-type-extensions.html" [
      "AllowAmbiguousTypes" .= "#ambiguity",
      "ImplicitParams" .= "#implicit-parameters",
      "NoMonomorphismRestriction" .= "#monomorphism",
      "RelaxedPolyRec" .= "#typing-binds",
      "MonoLocalBinds" .= "#mono-local-binds",
      "ScopedTypeVariables" .= "#scoped-type-variables",
      "ExplicitForAll" .= "#explicit-foralls",
      "PolymorphicComponents" .= "#universal-quantification",
      "Rank2Types" .= "#universal-quantification",
      "RankNTypes" .= "#universal-quantification",
      "ImpredicativeTypes" .= "#impredicative-polymorphism",
      "KindSignatures" .= "#kinding",
      "FlexibleContexts" .= "#flexible-contexts" ],

    prefix "type-class-extensions.html" [
      "IncoherentInstances" .= "#instance-overlap",
      "OverlappingInstances" .= "#instance-overlap",
      "OverloadedLists" .= "#overloaded-lists",
      "OverloadedStrings" .= "#overloaded-strings",
      "UndecidableInstances" .= "#undecidable-instances",
      "TypeSynonymInstances" .= "#flexible-instance-head",
      "FlexibleInstances" .= "#instance-rules",
      "ConstrainedClassMethods" .= "#class-method-types",
      "DefaultSignatures" .= "#class-default-signatures",
      "MultiParamTypeClasses" .= "#multi-param-type-classes",
      "NullaryTypeClasses" .= "#nullary-type-classes",
      "InstanceSigs" .= "#instance-sigs",
      "FunctionalDependencies" .= "#functional-dependencies" ],

    prefix "deriving.html" [
      "AutoDeriveTypeable" .= "#auto-derive-typeable",
      "DeriveDataTypeable" .= "#deriving-typeable",
      "DeriveGeneric" .= "#deriving-typeable",
      "DeriveFunctor" .= "#deriving-extra",
      "DeriveTraversable" .= "#deriving-extra",
      "DeriveFoldable" .= "#deriving-extra",
      "GeneralizedNewtypeDeriving" .= "#newtype-deriving",
      "DeriveAnyClass" .= "#derive-any-class",
      "StandaloneDeriving" .= "#stand-alone-deriving" ],

    prefix "template-haskell.html" [
      "TemplateHaskell" .= "",
      "QuasiQuotes" .= "#th-quasiquotation" ],

    prefix "ffi.html" [
      "ForeignFunctionInterface" .= "",
      "InterruptibleFFI" .= "#ffi-interruptible",
      "CApiFFI" .= "#ffi-capi" ],

    prefix "partial-type-signatures.html" [
      "PartialTypeSignatures" .= "",
      "NamedWildCards" .= "#named-wildcards" ],

    map (.= "safe-haskell.html") [
      "Safe",
      "Trustworthy",
      "Unsafe" ],

    [ "Arrows" .= "arrow-notation.html",
      "ConstraintKinds" .= "constraint-kind.html",
      "DataKinds" .= "promotion.html",
      "ExtendedDefaultRules" .= "interactive-evaluation.html#extended-default-rules",
      "TypeFamilies" .= "type-families.html",
      "PolyKinds" .= "kind-polymorphism.html",
      "BangPatterns" .= "bang-patterns.html",
      "CPP" .= "options-phases.html#c-pre-processor",
      "RoleAnnotations" .= "roles.html#role-annotations",
      "UnboxedTuples" .= "primitives.html#unboxed-tuples" ] ]

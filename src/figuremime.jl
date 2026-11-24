# A figure as Paperboat draws it (paperboat docs/runtime.md "Figures"): `scene_spec` as JSON, its binary
# payload base64. A Paperboat session sends a value that can show itself this way as that alone, so Julix
# and Malachite draw the figure themselves (pan, zoom, cursors, orbit) and export images on demand.

const FIGURE_MIME = MIME"application/vnd.paperboat.figure+json"

function Base.show(io::IO, ::FIGURE_MIME, fig::Figure)
    spec, bytes = scene_spec(fig)
    print(io, "{\"scene\":")
    _json(io, spec)
    print(io, ",\"buffers\":\"", base64encode(bytes), "\"}")
end
Base.show(io::IO, m::FIGURE_MIME, f::FigureAxisPlot) = show(io, m, f.figure)

# JSON, just enough for a scene: objects, arrays, strings, numbers (non-finite as null), booleans, null.
function _json(io::IO, x::AbstractDict)
    print(io, '{')
    first = true
    for (k, v) in x
        first || print(io, ',')
        first = false
        _json(io, string(k))
        print(io, ':')
        _json(io, v)
    end
    print(io, '}')
end
_json(io::IO, x::NamedTuple) = _json(io, Dict(pairs(x)))
function _json(io::IO, x::Union{AbstractVector, Tuple})
    print(io, '[')
    for (i, v) in enumerate(x)
        i > 1 && print(io, ',')
        _json(io, v)
    end
    print(io, ']')
end
function _json(io::IO, s::AbstractString)
    print(io, '"')
    for c in s
        if c == '"' || c == '\\'
            print(io, '\\', c)
        elseif c < ' '
            print(io, "\\u", string(UInt16(c); base = 16, pad = 4))
        else
            print(io, c)
        end
    end
    print(io, '"')
end
_json(io::IO, x::Symbol) = _json(io, string(x))
_json(io::IO, x::Bool) = print(io, x)
_json(io::IO, x::Integer) = print(io, x)
_json(io::IO, x::Real) = isfinite(x) ? print(io, Float64(x)) : print(io, "null")
_json(io::IO, ::Union{Nothing, Missing}) = print(io, "null")
_json(io::IO, x) = _json(io, string(x))
